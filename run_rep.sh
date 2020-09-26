
### 0

#unbuffer python project.py vae 3dshapes --info.extra dislib
#unbuffer python project.py vae 3dshapes --info.extra b16-dislib --model.reg_wt 16
#unbuffer python project.py pvae 3dshapes --info.extra b1-dislib --model.reg_wt 1
#unbuffer python project.py pvae 3dshapes --info.extra b16-dislib --model.reg_wt 16
#unbuffer python project.py wae 3dshapes --info.extra dislib
#unbuffer python project.py ae 3dshapes --info.extra dislib
#unbuffer python project.py ae 3dshapes --info.extra b1-dislib --model.reg_wt 1

### 1

#unbuffer python project.py vae conv 3dshapes --info.extra b1 --model.reg_wt 1
#unbuffer python project.py vae conv 3dshapes --info.extra b16 --model.reg_wt 16
#unbuffer python project.py pvae conv 3dshapes --info.extra b1 --model.reg_wt 1
#unbuffer python project.py pvae conv 3dshapes --info.extra b16 --model.reg_wt 16
#unbuffer python project.py wae conv 3dshapes
#unbuffer python project.py ae conv 3dshapes
#unbuffer python project.py ae conv 3dshapes --info.extra b1 --model.reg_wt 1

### 2

#unbuffer python project.py vae conv 3dshapes --info.extra b2 --model.reg_wt 2
#unbuffer python project.py vae conv 3dshapes --info.extra b4 --model.reg_wt 4
#unbuffer python project.py vae conv 3dshapes --info.extra b8 --model.reg_wt 8
#unbuffer python project.py vae conv 3dshapes --info.extra b32 --model.reg_wt 32
#unbuffer python project.py vae conv 3dshapes --info.extra b64 --model.reg_wt 64

### 3

#unbuffer python project.py wae conv 3dshapes --info.extra mish --model.nonlin mish
#unbuffer python project.py ae conv 3dshapes --info.extra mish --model.nonlin mish
#unbuffer python project.py ae conv 3dshapes --info.extra b1-mish --model.reg_wt 1 --model.nonlin mish
#unbuffer python project.py vae conv 3dshapes --info.extra mish --model.nonlin mish
#unbuffer python project.py vae conv 3dshapes --info.extra b16-mish --model.nonlin mish --model.reg_wt 16
#unbuffer python project.py pvae conv 3dshapes --info.extra b1-mish --model.nonlin mish --model.reg_wt 1
#unbuffer python project.py pvae conv 3dshapes --info.extra b16-mish --model.nonlin mish --model.reg_wt 16

### 4

#unbuffer python project.py pvae conv 3dshapes --info.extra b2 --model.reg_wt 2
#unbuffer python project.py pvae conv 3dshapes --info.extra b4 --model.reg_wt 4
#unbuffer python project.py pvae conv 3dshapes --info.extra b8 --model.reg_wt 8
#unbuffer python project.py pvae conv 3dshapes --info.extra b32 --model.reg_wt 32
#unbuffer python project.py pvae conv 3dshapes --info.extra b64 --model.reg_wt 64


###

#unbuffer python project.py a/conv m/vae 3dshapes --info.extra b1 --model.reg_wt 1
#unbuffer python project.py a/conv m/vae 3dshapes --info.extra b16 --model.reg_wt 16
#unbuffer python project.py a/conv m/pvae 3dshapes --info.extra b1 --model.reg_wt 1
#unbuffer python project.py a/conv m/pvae 3dshapes --info.extra b16 --model.reg_wt 16
#unbuffer python project.py a/conv m/wae 3dshapes
#unbuffer python project.py a/conv m/ae 3dshapes
#unbuffer python project.py a/conv m/ae 3dshapes --info.extra b1 --model.reg_wt 1


### 5

#unbuffer python project.py a/d/branch4 a/e/conv m/vae 3dshapes --info.extra 4b3-b1 --model.reg_wt 1
#unbuffer python project.py a/d/branch4 a/e/conv m/vae 3dshapes --info.extra 4b3-b16 --model.reg_wt 16
#unbuffer python project.py a/d/branch4 a/e/conv m/pvae 3dshapes --info.extra 4b3-b1 --model.reg_wt 1
#unbuffer python project.py a/d/branch4 a/e/conv m/pvae 3dshapes --info.extra 4b3-b16 --model.reg_wt 16
#unbuffer python project.py a/d/branch4 a/e/conv m/wae 3dshapes --info.extra 4b3
#unbuffer python project.py a/d/branch4 a/e/conv m/ae 3dshapes --info.extra 4b3
#unbuffer python project.py a/d/branch4 a/e/conv m/ae 3dshapes --info.extra 4b3-b1 --model.reg_wt 1

### 6

#unbuffer python project.py a/d/branch12 a/e/conv m/vae 3dshapes --info.extra 12b1-b1 --model.reg_wt 1
#unbuffer python project.py a/d/branch12 a/e/conv m/vae 3dshapes --info.extra 12b1-b16 --model.reg_wt 16
#unbuffer python project.py a/d/branch12 a/e/conv m/pvae 3dshapes --info.extra 12b1-b1 --model.reg_wt 1
#unbuffer python project.py a/d/branch12 a/e/conv m/pvae 3dshapes --info.extra 12b1-b16 --model.reg_wt 16
#unbuffer python project.py a/d/branch12 a/e/conv m/wae 3dshapes --info.extra 12b1
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-b1 --model.reg_wt 1

### 7

#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1 --seed 1
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1 --seed 2

### 8

#unbuffer python project.py a/d/branch6 a/e/conv m/ae 3dshapes --info.extra 6b2

#unbuffer python project.py a/d/root4 a/e/conv m/ae 3dshapes --info.extra 4b2r4
#unbuffer python project.py a/d/root8 a/e/conv m/ae 3dshapes --info.extra 4b1r8

### 9

#unbuffer python project.py a/d/branch4 a/e/conv m/pvae 3dshapes --info.extra 4b3-b1 --model.reg_wt 1
#unbuffer python project.py a/d/branch4 a/e/conv m/pvae 3dshapes --info.extra 4b3-b16 --model.reg_wt 16

#unbuffer python project.py a/d/branch12 a/e/conv m/pvae 3dshapes --info.extra 12b1-b1 --model.reg_wt 1
#unbuffer python project.py a/d/branch12 a/e/conv m/pvae 3dshapes --info.extra 12b1-b16 --model.reg_wt 16


### 10

#unbuffer python project.py a/d/branch4 a/e/conv m/ae 3dshapes --info.extra 4b3-shallow --model.branch_hidden []
#unbuffer python project.py a/d/branch6 a/e/conv m/ae 3dshapes --info.extra 6b2-shallow --model.branch_hidden []
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-shallow --model.branch_hidden []

#unbuffer python project.py a/d/branch4 a/e/conv m/ae 3dshapes --info.extra 4b3-wide --model.branch_hidden [512]
#unbuffer python project.py a/d/branch6 a/e/conv m/ae 3dshapes --info.extra 6b2-wide --model.branch_hidden [512]
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-wide --model.branch_hidden [512]

#unbuffer python project.py a/d/branch4 a/e/conv m/ae 3dshapes --info.extra 4b3-deep --model.branch_hidden [128,128,128]
#unbuffer python project.py a/d/branch6 a/e/conv m/ae 3dshapes --info.extra 6b2-deep --model.branch_hidden [128,128,128]
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-deep --model.branch_hidden [128,128,128]

### 11-12

#unbuffer python project.py --resume 3ds-vae-12b1-b1_0006-6241674-00_200414-020832
#unbuffer python project.py --resume 3ds-ae-12b1_0007-6241675-01_200414-020851
#unbuffer python project.py --resume 3ds-ae-12b1_0007-6241675-00_200414-020856
#unbuffer python project.py --resume 3ds-pvae-12b1-b16_0009-6241680-03_200414-021319
#unbuffer python project.py --resume 3ds-pvae-12b1-b1_0009-6241680-02_200414-021321
#unbuffer python project.py --resume 3ds-ae-12b1-deep_0010-6241682-08_200414-021349
#unbuffer python project.py --resume 3ds-ae-12b1-wide_0010-6241682-05_200414-021351

### 13

#unbuffer python project.py --resume 3ds-ae-12b1_0007-6241675-01_200414-020851
#unbuffer python project.py --resume 3ds-ae-12b1-deep_0010-6241682-08_200414-021349
#unbuffer python project.py --resume 3ds-pvae-12b1-b1_0009-6241680-02_200414-021321
#unbuffer python project.py --resume 3ds-vae-12b1-b1_0006-6241674-00_200414-020832

### 14

#unbuffer python project.py a/d/branch4 a/e/conv m/ae 3dshapes --info.extra 4b3-shallow --model.branch_hidden []
#unbuffer python project.py a/d/branch6 a/e/conv m/ae 3dshapes --info.extra 6b2-shallow --model.branch_hidden []
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-shallow --model.branch_hidden []

#unbuffer python project.py a/d/branch4 a/e/conv m/ae 3dshapes --info.extra 4b3-wide --model.branch_hidden [512]
#unbuffer python project.py a/d/branch6 a/e/conv m/ae 3dshapes --info.extra 6b2-wide --model.branch_hidden [512]
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-wide --model.branch_hidden [512]

#unbuffer python project.py a/d/branch4 a/e/conv m/ae 3dshapes --info.extra 4b3-deep --model.branch_hidden [128,128,128]
#unbuffer python project.py a/d/branch6 a/e/conv m/ae 3dshapes --info.extra 6b2-deep --model.branch_hidden [128,128,128]
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-deep --model.branch_hidden [128,128,128]

### 15

#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1 --seed 3
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1 --seed 4

### 16

#unbuffer python project.py a/d/branch6 a/e/conv m/ae 3dshapes --info.extra 6b1 --model.branch_dim 1 --model.latent_dim 6
#unbuffer python project.py a/d/branch8 a/e/conv m/ae 3dshapes --info.extra 8b1 --model.branch_dim 1 --model.latent_dim 8


### 17

#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --info.extra 12b1 --dataset.category real
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --info.extra 12b1 --dataset.category realistic
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --info.extra 12b1 --dataset.category toy

#unbuffer python project.py a/d/branch4 a/e/conv m/ae mpi3d --info.extra 4b3 --dataset.category real
#unbuffer python project.py a/d/branch4 a/e/conv m/ae mpi3d --info.extra 4b3 --dataset.category realistic
#unbuffer python project.py a/d/branch4 a/e/conv m/ae mpi3d --info.extra 4b3 --dataset.category toy

#unbuffer python project.py a/d/branch6 a/e/conv m/ae mpi3d --info.extra 6b2 --dataset.category real
#unbuffer python project.py a/d/branch6 a/e/conv m/ae mpi3d --info.extra 6b2 --dataset.category realistic
#unbuffer python project.py a/d/branch6 a/e/conv m/ae mpi3d --info.extra 6b2 --dataset.category toy

### 18

#unbuffer python project.py a/e/attn12 a/d/deconv m/ae 3dshapes --info.extra 12h4k64v64 --model.keys_per_head 4
#unbuffer python project.py a/e/attn12 a/d/deconv m/ae 3dshapes --info.extra 12h2k64v64 --model.keys_per_head 2
#unbuffer python project.py a/e/attn12 a/d/deconv m/ae 3dshapes --info.extra 12h1k64v64 --model.keys_per_head 1
#unbuffer python project.py a/e/attn12 a/d/deconv m/ae 3dshapes --info.extra 12h8k64v64 --model.keys_per_head 8

### 19

#unbuffer python project.py a/e/attn12 a/d/deconv m/ae 3dshapes --info.extra 12h4k64v64-wk --model.keys_per_head 4 --model.weight_keys 0

#unbuffer python project.py a/e/attn6 a/d/deconv m/ae 3dshapes --info.extra 6h4k64v64 --model.keys_per_head 4
#unbuffer python project.py a/e/attn4 a/d/deconv m/ae 3dshapes --info.extra 4h4k64v64 --model.keys_per_head 4

### 20

#unbuffer python project.py a/e/attn12 a/d/deconv m/ae 3dshapes --info.extra 12h4k8v8 --model.key_val_dim 16 --model.val_dim 8
#unbuffer python project.py a/e/attn12 a/d/deconv m/ae 3dshapes --info.extra 12h4k64v8 --model.key_val_dim 72 --model.val_dim 8
#unbuffer python project.py a/e/attn12 a/d/deconv m/ae 3dshapes --info.extra 12h4k8v64 --model.key_val_dim 72 --model.val_dim 64

### 21

#unbuffer python project.py a/e/attn12 a/d/deconv m/ae 3dshapes --info.extra 12h4k64v64-shallowtfm --model.point_tfm_hidden [128]
#unbuffer python project.py a/e/attn12 a/d/deconv m/ae 3dshapes --info.extra 12h4k64v64-deeptfm --model.point_tfm_hidden [128,128,128,128,128]
#unbuffer python project.py a/e/attn12 a/d/deconv m/ae 3dshapes --info.extra 12h4k64v64-widetfm --model.point_tfm_hidden [512,512]

#unbuffer python project.py a/e/attn12 a/d/deconv m/ae 3dshapes --info.extra 12h4k64v64-deephead --model.head_hidden [128,128,128,128,128]
#unbuffer python project.py a/e/attn12 a/d/deconv m/ae 3dshapes --info.extra 12h4k64v64-shallowhead --model.head_hidden []
#unbuffer python project.py a/e/attn12 a/d/deconv m/ae 3dshapes --info.extra 12h4k64v64-widehead --model.head_hidden [256,256]


### 22

#unbuffer python project.py a/e/attn12 a/d/branch12 m/ae 3dshapes --info.extra 12b1-12h4kv64

#unbuffer python project.py a/e/attn6 a/d/branch6 m/ae 3dshapes --info.extra 6b2-6h4kv64

#unbuffer python project.py a/e/attn4 a/d/branch4 m/ae 3dshapes --info.extra 4b3-4h4kv64

### 23

#unbuffer python project.py a/conv m/vae mpi3d --dataset.category toy --info.extra b1 --model.reg_wt 1
#unbuffer python project.py a/conv m/vae mpi3d --dataset.category toy --info.extra b16 --model.reg_wt 16
#unbuffer python project.py a/conv m/pvae mpi3d --dataset.category toy --info.extra b1 --model.reg_wt 1
#unbuffer python project.py a/conv m/pvae mpi3d --dataset.category toy --info.extra b16 --model.reg_wt 16
#unbuffer python project.py a/conv m/wae mpi3d --dataset.category toy
#unbuffer python project.py a/conv m/ae mpi3d --dataset.category toy
#unbuffer python project.py a/conv m/ae mpi3d --dataset.category toy --info.extra b1 --model.reg_wt 1

### 24

#unbuffer python project.py a/conv m/vae mpi3d --dataset.category realistic --info.extra b1 --model.reg_wt 1
#unbuffer python project.py a/conv m/vae mpi3d --dataset.category realistic --info.extra b16 --model.reg_wt 16
#unbuffer python project.py a/conv m/pvae mpi3d --dataset.category realistic --info.extra b1 --model.reg_wt 1
#unbuffer python project.py a/conv m/pvae mpi3d --dataset.category realistic --info.extra b16 --model.reg_wt 16
#unbuffer python project.py a/conv m/wae mpi3d --dataset.category realistic
#unbuffer python project.py a/conv m/ae mpi3d --dataset.category realistic
#unbuffer python project.py a/conv m/ae mpi3d --dataset.category realistic --info.extra b1 --model.reg_wt 1

### 25

#unbuffer python project.py a/conv m/vae mpi3d --dataset.category real --info.extra b1 --model.reg_wt 1
#unbuffer python project.py a/conv m/vae mpi3d --dataset.category real --info.extra b16 --model.reg_wt 16
#unbuffer python project.py a/conv m/pvae mpi3d --dataset.category real --info.extra b1 --model.reg_wt 1
#unbuffer python project.py a/conv m/pvae mpi3d --dataset.category real --info.extra b16 --model.reg_wt 16
#unbuffer python project.py a/conv m/wae mpi3d --dataset.category real
#unbuffer python project.py a/conv m/ae mpi3d --dataset.category real
#unbuffer python project.py a/conv m/ae mpi3d --dataset.category real --info.extra b1 --model.reg_wt 1

### 26

#unbuffer python project.py a/e/attn12 a/d/deconv m/ae 3dshapes --info.extra 12h4k64v64-nocoord --model.coord_patches 0
#unbuffer python project.py a/e/attn12 a/d/deconv m/ae 3dshapes --info.extra 12h2k64v64-nocoord --model.keys_per_head 2 --model.coord_patches 0
#unbuffer python project.py a/e/attn12 a/d/deconv m/ae 3dshapes --info.extra 12h8k64v64-nocoord --model.keys_per_head 8 --model.coord_patches 0

#unbuffer python project.py a/e/attn12 a/d/branch12 m/ae 3dshapes --info.extra 12b1-12h4kv64-nocoord --model.coord_patches 0

### 27

#unbuffer python project.py a/e/attn4 a/d/deconv m/ae 3dshapes --info.extra 4h4k64v64-nocoord --model.coord_patches 0
#unbuffer python project.py a/e/attn6 a/d/deconv m/ae 3dshapes --info.extra 6h4k64v64-nocoord --model.coord_patches 0

#unbuffer python project.py a/e/attn4 a/d/branch4 m/ae 3dshapes --info.extra 4b3-4h4kv64-nocoord --model.coord_patches 0
#unbuffer python project.py a/e/attn6 a/d/branch6 m/ae 3dshapes --info.extra 6b2-6h4kv64-nocoord --model.coord_patches 0


### 28 incomp

#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-wide-seed1 --model.branch_hidden [512] --seed 1
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-deep-seed1 --model.branch_hidden [128,128,128] --seed 1

### 29 attn

#unbuffer python project.py a/e/attn12 a/d/deconv m/ae 3dshapes --info.extra 12h2k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn12 a/d/deconv m/ae 3dshapes --info.extra 12h4k32v32 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32

#unbuffer python project.py a/e/attn12 a/d/deconv m/ae 3dshapes --info.extra 12h2k32v32-nc --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32 --model.coord_patches 0
#unbuffer python project.py a/e/attn12 a/d/deconv m/ae 3dshapes --info.extra 12h4k32v32-nc --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32 --model.coord_patches 0


#unbuffer python project.py a/e/attn6 a/d/deconv m/ae 3dshapes --info.extra 6h2k16v16 --model.keys_per_head 2 --model.key_val_dim 32 --model.val_dim 16
#unbuffer python project.py a/e/attn6 a/d/deconv m/ae 3dshapes --info.extra 6h4k16v16 --model.keys_per_head 4 --model.key_val_dim 32 --model.val_dim 16

#unbuffer python project.py a/e/attn6 a/d/deconv m/ae 3dshapes --info.extra 6h2k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn6 a/d/deconv m/ae 3dshapes --info.extra 6h4k32v32 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32

#unbuffer python project.py a/e/attn6 a/d/deconv m/ae 3dshapes --info.extra 6h2k32v32-nc --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32 --model.coord_patches 0
#unbuffer python project.py a/e/attn6 a/d/deconv m/ae 3dshapes --info.extra 6h4k32v32-nc --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32 --model.coord_patches 0


#unbuffer python project.py a/e/attn4 a/d/deconv m/ae 3dshapes --info.extra 4h2k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn4 a/d/deconv m/ae 3dshapes --info.extra 4h4k32v32 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32


#unbuffer python project.py a/e/attn6 a/d/deconv m/ae 3dshapes --info.extra 6h2k32v32-thickwide --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32 --model.head_hidden [256,256,256]
#unbuffer python project.py a/e/attn6 a/d/deconv m/ae 3dshapes --info.extra 6h4k32v32-thickwide --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32 --model.head_hidden [256,256,256]

#unbuffer python project.py a/e/attn6 a/d/deconv m/ae 3dshapes --info.extra 6h4k32v32-slim --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32 --model.head_hidden [128,128]
#unbuffer python project.py a/e/attn6 a/d/deconv m/ae 3dshapes --info.extra 6h4k32v32-slimwide --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32 --model.head_hidden [256,256]

### 30 sym combos

#unbuffer python project.py a/e/attn12 a/d/branch12 m/ae 3dshapes --info.extra 12b1-12h2k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn12 a/d/branch12 m/ae 3dshapes --info.extra 12b1-12h2k32v32-seed1 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32 --seed 1

#unbuffer python project.py a/e/attn12 a/d/branch12 m/ae 3dshapes --info.extra 12b1-12h4k32v32 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn12 a/d/branch12 m/ae 3dshapes --info.extra 12b1-12h4k32v32-seed1 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32 --seed 1


#unbuffer python project.py a/e/attn6 a/d/branch6 m/ae 3dshapes --info.extra 6b2-6h2k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn6 a/d/branch6 m/ae 3dshapes --info.extra 6b2-6h2k32v32-seed1 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32 --seed 1

#unbuffer python project.py a/e/attn6 a/d/branch6 m/ae 3dshapes --info.extra 6b2-6h4k32v32 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn6 a/d/branch6 m/ae 3dshapes --info.extra 6b2-6h4k32v32-seed1 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32 --seed 1

### 31 asym combos

#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h4k64v64 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64
#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h4k32v32 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32

#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h2k64v64 --model.keys_per_head 2 --model.key_val_dim 128 --model.val_dim 64
#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h2k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32

#unbuffer python project.py a/e/attn4 a/d/branch6 m/ae 3dshapes --info.extra 6b2-4h2k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn4 a/d/branch6 m/ae 3dshapes --info.extra 6b4-4h4k32v32 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32

#unbuffer python project.py a/e/attn6 a/d/branch6 m/ae 3dshapes --info.extra 6b2-12h2k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn6 a/d/branch4 m/ae 3dshapes --info.extra 4b3-12h2k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32

### 32 asym combos backup

#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h4k64v64-seed1 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64 --seed 1
#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h4k32v32-seed1 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32 --seed 1

#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h2k64v64-seed1 --model.keys_per_head 2 --model.key_val_dim 128 --model.val_dim 64 --seed 1
#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h2k32v32-seed1 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32 --seed 1

### 33 mpi

#unbuffer python project.py a/e/attn12 a/d/branch12 m/ae mpi3d --dataset.category toy --info.extra 12b1-12h2k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn12 a/d/branch12 m/ae mpi3d --dataset.category toy --info.extra 12b1-12h2k32v32-seed1 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32 --seed 1

#unbuffer python project.py a/e/attn12 a/d/branch12 m/ae mpi3d --dataset.category toy --info.extra 12b1-12h4k32v32 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn12 a/d/branch12 m/ae mpi3d --dataset.category toy --info.extra 12b1-12h4k32v32-seed1 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32 --seed 1


#unbuffer python project.py a/e/attn6 a/d/branch6 m/ae mpi3d --dataset.category toy --info.extra 6b2-6h2k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn6 a/d/branch6 m/ae mpi3d --dataset.category toy --info.extra 6b2-6h2k32v32-seed1 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32 --seed 1

#unbuffer python project.py a/e/attn6 a/d/branch6 m/ae mpi3d --dataset.category toy --info.extra 6b2-6h4k32v32 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn6 a/d/branch6 m/ae mpi3d --dataset.category toy --info.extra 6b2-6h4k32v32-seed1 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32 --seed 1


#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae mpi3d --dataset.category toy --info.extra 12b1-6h4k64v64 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64
#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae mpi3d --dataset.category toy --info.extra 12b1-6h4k32v32 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32

#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae mpi3d --dataset.category toy --info.extra 12b1-6h2k64v64 --model.keys_per_head 2 --model.key_val_dim 128 --model.val_dim 64
#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae mpi3d --dataset.category toy --info.extra 12b1-6h2k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32

#unbuffer python project.py a/e/attn4 a/d/branch6 m/ae mpi3d --dataset.category toy --info.extra 6b2-4h2k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn4 a/d/branch6 m/ae mpi3d --dataset.category toy --info.extra 6b4-4h4k32v32 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32

#unbuffer python project.py a/e/attn6 a/d/branch6 m/ae mpi3d --dataset.category toy --info.extra 6b2-12h2k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn6 a/d/branch4 m/ae mpi3d --dataset.category toy --info.extra 4b3-12h2k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32

### 34

#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h4k64v64 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64
#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h4k32v32 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32

#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h2k64v64 --model.keys_per_head 2 --model.key_val_dim 128 --model.val_dim 64
#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h2k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32

#unbuffer python project.py a/e/attn4 a/d/branch6 m/ae 3dshapes --info.extra 6b2-4h2k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn4 a/d/branch6 m/ae 3dshapes --info.extra 6b2-4h4k32v32 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32

#unbuffer python project.py a/e/attn6 a/d/branch4 m/ae 3dshapes --info.extra 4b3-6h2k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn6 a/d/branch4 m/ae 3dshapes --info.extra 4b3-6h4k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32

#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h4k64v64-seed1 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64 --seed 1
#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h4k32v32-seed1 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32 --seed 1

#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h2k64v64-seed1 --model.keys_per_head 2 --model.key_val_dim 128 --model.val_dim 64 --seed 1
#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h2k32v32-seed1 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32 --seed 1

### 35

#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae mpi3d --dataset.category toy --info.extra 12b1-6h4k64v64 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64
#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae mpi3d --dataset.category toy --info.extra 12b1-6h4k32v32 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32

#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae mpi3d --dataset.category toy --info.extra 12b1-6h2k64v64 --model.keys_per_head 2 --model.key_val_dim 128 --model.val_dim 64
#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae mpi3d --dataset.category toy --info.extra 12b1-6h2k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32

#unbuffer python project.py a/e/attn4 a/d/branch6 m/ae mpi3d --dataset.category toy --info.extra 6b2-4h2k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn4 a/d/branch6 m/ae mpi3d --dataset.category toy --info.extra 6b2-4h4k32v32 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32

#unbuffer python project.py a/e/attn6 a/d/branch4 m/ae mpi3d --dataset.category toy --info.extra 4b3-6h2k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn6 a/d/branch4 m/ae mpi3d --dataset.category toy --info.extra 4b3-6h4k32v32 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32

### 36

#unbuffer python project.py a/conv m/vae 3dshapes --info.extra b1 --model.reg_wt 1
#unbuffer python project.py a/conv m/vae 3dshapes --info.extra b16 --model.reg_wt 16
#unbuffer python project.py a/conv m/pvae 3dshapes --info.extra b1 --model.reg_wt 1
#unbuffer python project.py a/conv m/pvae 3dshapes --info.extra b16 --model.reg_wt 16
#unbuffer python project.py a/conv m/wae 3dshapes
#unbuffer python project.py a/conv m/ae 3dshapes
#unbuffer python project.py a/conv m/ae 3dshapes --info.extra b1 --model.reg_wt 1

### 37

#unbuffer python project.py --resume mpi3d-ae-12b1-12h2k32v32_0033-6246720-00_200415-174714
#unbuffer python project.py --resume mpi3d-ae-6b2-6h2k32v32_0033-6246720-04_200415-174707
#unbuffer python project.py --resume mpi3d-ae-6b2-6h2k32v32-seed1_0033-6246720-05_200415-174706
#unbuffer python project.py --resume mpi3d-ae-6b2-6h4k32v32_0033-6246720-06_200415-174713


### 38 stability test

#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-seed5 --seed 5
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-seed5 --seed 6
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-seed5 --seed 7
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-seed5 --seed 8
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-seed5 --seed 9

#unbuffer python project.py a/d/deconv-deep a/e/conv m/ae 3dshapes --info.extra deep-conv-seed5 --seed 5
#unbuffer python project.py a/d/deconv-deep a/e/conv m/ae 3dshapes --info.extra deep-conv-seed6 --seed 6
#unbuffer python project.py a/d/deconv-deep a/e/conv m/ae 3dshapes --info.extra deep-conv-seed7 --seed 7
#unbuffer python project.py a/d/deconv-deep a/e/conv m/ae 3dshapes --info.extra deep-conv-seed8 --seed 8
#unbuffer python project.py a/d/deconv-deep a/e/conv m/ae 3dshapes --info.extra deep-conv-seed9 --seed 9

#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-instance-seed5 --seed 5 --model.norm instance
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-instance-seed6 --seed 6 --model.norm instance
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-instance-seed7 --seed 7 --model.norm instance
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-instance-seed8 --seed 8 --model.norm instance
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-instance-seed9 --seed 9 --model.norm instance

#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-res-seed5 --seed 5 --model.residual --model.norm None
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-res-seed6 --seed 6 --model.residual --model.norm None
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-res-seed7 --seed 7 --model.residual --model.norm None
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-res-seed8 --seed 8 --model.residual --model.norm None
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-res-seed9 --seed 9 --model.residual --model.norm None

#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-resonly-seed5 --seed 5 --model.residual
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-resonly-seed6 --seed 6 --model.residual
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-resonly-seed7 --seed 7 --model.residual
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-resonly-seed8 --seed 8 --model.residual
#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-resonly-seed9 --seed 9 --model.residual


### 39

#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category toy --info.extra 12b1-seed5 --seed 5
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category toy --info.extra 12b1-seed5 --seed 6
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category toy --info.extra 12b1-seed5 --seed 7
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category toy --info.extra 12b1-seed5 --seed 8
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category toy --info.extra 12b1-seed5 --seed 9

#unbuffer python project.py a/d/deconv-deep a/e/conv m/ae mpi3d --dataset.category toy --info.extra deep-conv-seed5 --seed 5
#unbuffer python project.py a/d/deconv-deep a/e/conv m/ae mpi3d --dataset.category toy --info.extra deep-conv-seed6 --seed 6
#unbuffer python project.py a/d/deconv-deep a/e/conv m/ae mpi3d --dataset.category toy --info.extra deep-conv-seed7 --seed 7
#unbuffer python project.py a/d/deconv-deep a/e/conv m/ae mpi3d --dataset.category toy --info.extra deep-conv-seed8 --seed 8
#unbuffer python project.py a/d/deconv-deep a/e/conv m/ae mpi3d --dataset.category toy --info.extra deep-conv-seed9 --seed 9

#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category toy --info.extra 12b1-instance-seed5 --seed 5 --model.norm instance
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category toy --info.extra 12b1-instance-seed6 --seed 6 --model.norm instance
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category toy --info.extra 12b1-instance-seed7 --seed 7 --model.norm instance
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category toy --info.extra 12b1-instance-seed8 --seed 8 --model.norm instance
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category toy --info.extra 12b1-instance-seed9 --seed 9 --model.norm instance

#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category toy --info.extra 12b1-res-seed5 --seed 5 --model.residual --model.norm None
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category toy --info.extra 12b1-res-seed6 --seed 6 --model.residual --model.norm None
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category toy --info.extra 12b1-res-seed7 --seed 7 --model.residual --model.norm None
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category toy --info.extra 12b1-res-seed8 --seed 8 --model.residual --model.norm None
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category toy --info.extra 12b1-res-seed9 --seed 9 --model.residual --model.norm None

#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category toy --info.extra 12b1-resonly-seed5 --seed 5 --model.residual
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category toy --info.extra 12b1-resonly-seed6 --seed 6 --model.residual
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category toy --info.extra 12b1-resonly-seed7 --seed 7 --model.residual
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category toy --info.extra 12b1-resonly-seed8 --seed 8 --model.residual
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category toy --info.extra 12b1-resonly-seed9 --seed 9 --model.residual

### 40

#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h4k64v64-seed5 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64 --seed 5
#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h4k64v64-seed6 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64 --seed 6
#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h4k64v64-seed7 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64 --seed 7
#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h4k64v64-seed8 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64 --seed 8
#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h4k64v64-seed9 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64 --seed 9

#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h2k64v64-seed5 --model.keys_per_head 2 --model.key_val_dim 128 --model.val_dim 64 --seed 5
#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h2k64v64-seed6 --model.keys_per_head 2 --model.key_val_dim 128 --model.val_dim 64 --seed 6
#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h2k64v64-seed7 --model.keys_per_head 2 --model.key_val_dim 128 --model.val_dim 64 --seed 7
#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h2k64v64-seed8 --model.keys_per_head 2 --model.key_val_dim 128 --model.val_dim 64 --seed 8
#unbuffer python project.py a/e/attn6 a/d/branch12 m/ae 3dshapes --info.extra 12b1-6h2k64v64-seed9 --model.keys_per_head 2 --model.key_val_dim 128 --model.val_dim 64 --seed 9


### 41

#unbuffer python project.py a/e/attn12 a/d/branch12 m/ae 3dshapes --info.extra 12b1-12h4k64v64-seed5 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64 --seed 5
#unbuffer python project.py a/e/attn12 a/d/branch12 m/ae 3dshapes --info.extra 12b1-12h4k64v64-seed6 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64 --seed 6
#unbuffer python project.py a/e/attn12 a/d/branch12 m/ae 3dshapes --info.extra 12b1-12h4k64v64-seed7 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64 --seed 7
#unbuffer python project.py a/e/attn12 a/d/branch12 m/ae 3dshapes --info.extra 12b1-12h4k64v64-seed8 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64 --seed 8
#unbuffer python project.py a/e/attn12 a/d/branch12 m/ae 3dshapes --info.extra 12b1-12h4k64v64-seed9 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64 --seed 9

### 42 - same as above but mpi3d


### 43

#unbuffer python project.py a/conv m/vae 3dshapes --info.extra b1-inst --model.reg_wt 1 --model.norm instance
#unbuffer python project.py a/conv m/vae 3dshapes --info.extra b16-inst --model.reg_wt 16 --model.norm instance
#unbuffer python project.py a/conv m/pvae 3dshapes --info.extra b1-inst --model.reg_wt 1 --model.norm instance
#unbuffer python project.py a/conv m/pvae 3dshapes --info.extra b16-inst --model.reg_wt 16 --model.norm instance
#unbuffer python project.py a/conv m/wae 3dshapes --info.extra inst --model.norm instance
#unbuffer python project.py a/conv m/ae 3dshapes --info.extra inst --model.norm instance
#unbuffer python project.py a/conv m/ae 3dshapes --info.extra b1-inst --model.reg_wt 1 --model.norm instance


### 44

#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category real --info.extra 12b1-seed5 --seed 5
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category real --info.extra 12b1-seed5 --seed 6
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category real --info.extra 12b1-seed5 --seed 7
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category real --info.extra 12b1-seed5 --seed 8
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category real --info.extra 12b1-seed5 --seed 9

#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category real --info.extra 12b1-instance-seed5 --seed 5 --model.norm instance
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category real --info.extra 12b1-instance-seed6 --seed 6 --model.norm instance
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category real --info.extra 12b1-instance-seed7 --seed 7 --model.norm instance
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category real --info.extra 12b1-instance-seed8 --seed 8 --model.norm instance
#unbuffer python project.py a/d/branch12 a/e/conv m/ae mpi3d --dataset.category real --info.extra 12b1-instance-seed9 --seed 9 --model.norm instance

### 45-46

#unbuffer python project.py a/conv m/vae mpi3d --dataset.category toy --info.extra l-b1 --model.reg_wt 1
#unbuffer python project.py a/conv m/vae mpi3d --dataset.category toy --info.extra l-b16 --model.reg_wt 16
#unbuffer python project.py a/conv m/pvae mpi3d --dataset.category toy --info.extra l-b1 --model.reg_wt 1
#unbuffer python project.py a/conv m/pvae mpi3d --dataset.category toy --info.extra l-b16 --model.reg_wt 16
#unbuffer python project.py a/conv m/wae mpi3d --dataset.category toy --info.extra l
#unbuffer python project.py a/conv m/ae mpi3d --dataset.category toy --info.extra l
#unbuffer python project.py a/conv m/ae mpi3d --dataset.category toy --info.extra l-b1 --model.reg_wt 1

#unbuffer python project.py a/conv m/vae mpi3d --dataset.category toy --info.extra l-b1-inst --model.reg_wt 1 --model.norm instance
#unbuffer python project.py a/conv m/vae mpi3d --dataset.category toy --info.extra l-b16-inst --model.reg_wt 16 --model.norm instance
#unbuffer python project.py a/conv m/pvae mpi3d --dataset.category toy --info.extra l-b1-inst --model.reg_wt 1 --model.norm instance
#unbuffer python project.py a/conv m/pvae mpi3d --dataset.category toy --info.extra l-b16-inst --model.reg_wt 16 --model.norm instance
#unbuffer python project.py a/conv m/wae mpi3d --dataset.category toy --info.extra l-inst --model.norm instance
#unbuffer python project.py a/conv m/ae mpi3d --dataset.category toy --info.extra l-inst --model.norm instance
#unbuffer python project.py a/conv m/ae mpi3d --dataset.category toy --info.extra l-b1-inst --model.reg_wt 1 --model.norm instance

### 47

#unbuffer python project.py a/dislib m/vae mpi3d --dataset.category toy --info.extra b1 --model.reg_wt 1
#unbuffer python project.py a/dislib m/vae mpi3d --dataset.category toy --info.extra b4 --model.reg_wt 4
#unbuffer python project.py a/dislib m/pvae mpi3d --dataset.category toy --info.extra b1 --model.reg_wt 1
#unbuffer python project.py a/dislib m/pvae mpi3d --dataset.category toy --info.extra b4 --model.reg_wt 4
#unbuffer python project.py a/dislib m/wae mpi3d --dataset.category toy
#unbuffer python project.py a/dislib m/ae mpi3d --dataset.category toy
#unbuffer python project.py a/dislib m/ae mpi3d --dataset.category toy --info.extra b1 --model.reg_wt 1

### 48

#unbuffer python project.py a/dislib m/pvae mpi3d --dataset.category toy --info.extra b2 --model.reg_wt 2
#unbuffer python project.py a/dislib m/vae mpi3d --dataset.category toy --info.extra b2 --model.reg_wt 2

### 49

#unbuffer python project.py a/dislib m/vae t/3ds-shapes --info.extra b1 --model.reg_wt 1
#unbuffer python project.py a/dislib m/vae t/3ds-shapes --info.extra b4 --model.reg_wt 4
#unbuffer python project.py a/dislib m/pvae t/3ds-shapes --info.extra b1 --model.reg_wt 1
#unbuffer python project.py a/dislib m/pvae t/3ds-shapes --info.extra b4 --model.reg_wt 4
#unbuffer python project.py a/dislib m/wae t/3ds-shapes
#unbuffer python project.py a/dislib m/ae t/3ds-shapes
#unbuffer python project.py a/dislib m/ae t/3ds-shapes --info.extra b1 --model.reg_wt 1

### 50

#unbuffer python project.py a/dislib t/3ds-shapes m/vae --info.extra b1 --model.reg_wt 1
#unbuffer python project.py a/dislib t/3ds-shapes m/vae --info.extra b4 --model.reg_wt 4
#unbuffer python project.py a/dislib t/3ds-shapes m/pvae --info.extra b1 --model.reg_wt 1
#unbuffer python project.py a/dislib t/3ds-shapes m/pvae --info.extra b4 --model.reg_wt 4
#unbuffer python project.py a/dislib t/3ds-shapes m/wae
#unbuffer python project.py a/dislib t/3ds-shapes m/ae
#unbuffer python project.py a/dislib t/3ds-shapes m/ae --info.extra b1 --model.reg_wt 1

### 51

#unbuffer python project.py a/double 3dshapes m/ae --info.extra dbl
#unbuffer python project.py a/double 3dshapes m/ae --info.extra b1-dbl --model.reg_wt 1
#unbuffer python project.py a/double 3dshapes m/wae --info.extra dbl
#unbuffer python project.py a/double 3dshapes m/vae --info.extra b1-dbl --model.reg_wt 1
#unbuffer python project.py a/double 3dshapes m/vae --info.extra b4-dbl --model.reg_wt 4
#unbuffer python project.py a/double 3dshapes m/vae --info.extra b16-dbl --model.reg_wt 16


### 52

#unbuffer python project.py a/d/branch12 a/e/conv 3dshapes m/ae --info.extra 12b1
#unbuffer python project.py a/d/branch12 a/e/double 3dshapes m/ae --info.extra 12b1-dbl


### 53-54

#unbuffer python project.py a/dislib t/3ds-shapes m/ae --info.extra dislib
#unbuffer python project.py a/dislib t/3ds-shapes m/vae --info.extra b1-dislib --model.reg_wt 1
#unbuffer python project.py a/dislib t/3ds-shapes m/vae --info.extra b16-dislib --model.reg_wt 16

#unbuffer python project.py a/conv t/3ds-shapes m/ae --info.extra conv
#unbuffer python project.py a/conv t/3ds-shapes m/vae --info.extra b1-conv --model.reg_wt 1
#unbuffer python project.py a/conv t/3ds-shapes m/vae --info.extra b16-conv --model.reg_wt 16

#unbuffer python project.py a/double t/3ds-shapes m/ae --info.extra dbl
#unbuffer python project.py a/double m/vae t/3ds-shapes --info.extra b1-dbl --model.reg_wt 1
#unbuffer python project.py a/double m/vae t/3ds-shapes --info.extra b16-dbl --model.reg_wt 16

#unbuffer python project.py a/d/branch12 a/e/dislib t/3ds-shapes m/ae --info.extra 12b1-dislib
#unbuffer python project.py a/d/branch12 a/e/conv t/3ds-shapes m/ae --info.extra 12b1-conv
#unbuffer python project.py a/d/branch12 a/e/double t/3ds-shapes m/ae --info.extra 12b1-dbl


### 55-56,58

#unbuffer python project.py t/upd --load "t3ds-shapes-ae-dislib_0053-6286540-00_200429-032431"
#unbuffer python project.py t/upd --load "t3ds-shapes-ae-conv_0053-6286540-03_200429-040022"
#unbuffer python project.py t/upd --load "t3ds-shapes-ae-12b1-conv_0053-6286540-10_200429-041524"

### 57

#unbuffer python project.py a/double m/vae t/3ds-shapes --info.extra b1-dbl --model.reg_wt 1
#unbuffer python project.py a/double m/vae t/3ds-shapes --info.extra b16-dbl --model.reg_wt 16


### 60-61

################################


### 0


#unbuffer python project.py a/dislib t/3ds-shapes m/ae --info.extra dislib-t10k --train_limit 10000
#unbuffer python project.py a/conv t/3ds-shapes m/ae --info.extra conv-t10k --train_limit 10000
#unbuffer python project.py a/d/branch12 a/e/conv t/3ds-shapes m/ae --info.extra 12b1-conv-t10k --train_limit 10000

#unbuffer python project.py a/dislib t/3ds-shapes m/ae --info.extra dislib-t25k --train_limit 25000
#unbuffer python project.py a/conv t/3ds-shapes m/ae --info.extra conv-t25k --train_limit 25000
#unbuffer python project.py a/d/branch12 a/e/conv t/3ds-shapes m/ae --info.extra 12b1-conv-t25k --train_limit 25000

#unbuffer python project.py a/dislib t/3ds-shapes m/ae --info.extra dislib-t50k --train_limit 50000
#unbuffer python project.py a/conv t/3ds-shapes m/ae --info.extra conv-t50k --train_limit 50000
#unbuffer python project.py a/d/branch12 a/e/conv t/3ds-shapes m/ae --info.extra 12b1-conv-t50k --train_limit 50000

#unbuffer python project.py a/dislib t/3ds-shapes m/ae --info.extra dislib-t75k --train_limit 75000
#unbuffer python project.py a/conv t/3ds-shapes m/ae --info.extra conv-t75k --train_limit 75000
#unbuffer python project.py a/d/branch12 a/e/conv t/3ds-shapes m/ae --info.extra 12b1-conv-t75k --train_limit 75000

#unbuffer python project.py a/dislib t/3ds-shapes m/ae --info.extra dislib-t100k --train_limit 100000
#unbuffer python project.py a/conv t/3ds-shapes m/ae --info.extra conv-t100k --train_limit 100000
#unbuffer python project.py a/d/branch12 a/e/conv t/3ds-shapes m/ae --info.extra 12b1-conv-t100k --train_limit 100000


### 3

#unbuffer python project.py a/d/branch12 a/e/conv t/3ds-shapes m/ae --info.extra 12b1-conv-t10k --train_limit 10000 --model.lr 0.0001
#unbuffer python project.py a/d/branch12 a/e/conv t/3ds-shapes m/ae --info.extra 12b1-conv-t25k --train_limit 25000 --model.lr 0.0001
#unbuffer python project.py a/d/branch12 a/e/conv t/3ds-shapes m/ae --info.extra 12b1-conv-t50k --train_limit 50000 --model.lr 0.0001
#unbuffer python project.py a/d/branch12 a/e/conv t/3ds-shapes m/ae --info.extra 12b1-conv-t75k --train_limit 75000 --model.lr 0.0001
#unbuffer python project.py a/d/branch12 a/e/conv t/3ds-shapes m/ae --info.extra 12b1-conv-t100k --train_limit 100000 --model.lr 0.0001

### 4

#unbuffer python project.py a/d/branch12 a/e/conv t/3ds-shapes m/ae --info.extra 12b1-conv-t10k-5lr --train_limit 10000 --model.lr 0.0005
#unbuffer python project.py a/d/branch12 a/e/conv t/3ds-shapes m/ae --info.extra 12b1-conv-t25k-5lr --train_limit 25000 --model.lr 0.0005
#unbuffer python project.py a/d/branch12 a/e/conv t/3ds-shapes m/ae --info.extra 12b1-conv-t50k-5lr --train_limit 50000 --model.lr 0.0005
#unbuffer python project.py a/d/branch12 a/e/conv t/3ds-shapes m/ae --info.extra 12b1-conv-t75k-5lr --train_limit 75000 --model.lr 0.0005
#unbuffer python project.py a/d/branch12 a/e/conv t/3ds-shapes m/ae --info.extra 12b1-conv-t100k-5lr --train_limit 100000 --model.lr 0.0005

### 5

#unbuffer python project.py a/d/branch12 a/e/conv t/3ds-shapes m/ae --info.extra 12b1-conv-t10k-2lr --train_limit 10000 --model.lr 0.0002
#unbuffer python project.py a/d/branch12 a/e/conv t/3ds-shapes m/ae --info.extra 12b1-conv-t25k-2lr --train_limit 25000 --model.lr 0.0002
#unbuffer python project.py a/d/branch12 a/e/conv t/3ds-shapes m/ae --info.extra 12b1-conv-t50k-2lr --train_limit 50000 --model.lr 0.0002
#unbuffer python project.py a/d/branch12 a/e/conv t/3ds-shapes m/ae --info.extra 12b1-conv-t75k-2lr --train_limit 75000 --model.lr 0.0002
#unbuffer python project.py a/d/branch12 a/e/conv t/3ds-shapes m/ae --info.extra 12b1-conv-t100k-2lr --train_limit 100000 --model.lr 0.0002


### 6

#unbuffer python project.py a/e/attn12 a/d/branch12 m/ae 3dshapes --info.extra 12b1-12h4k64v64-seed5 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64 --seed 5
#unbuffer python project.py a/e/attn12 a/d/branch12 m/ae 3dshapes --info.extra 12b1-12h4k64v64-seed6 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64 --seed 6
#unbuffer python project.py a/e/attn12 a/d/branch12 m/ae 3dshapes --info.extra 12b1-12h4k64v64-seed7 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64 --seed 7

#unbuffer python project.py a/e/attn12 a/d/branch12 m/ae 3dshapes --info.extra 12b1-12attn


###############################



### 0

#unbuffer python project.py a/double 3dshapes m/ae --info.extra dbl
#unbuffer python project.py a/double 3dshapes m/ae --info.extra b1-dbl --model.reg_wt 1
#unbuffer python project.py a/double 3dshapes m/wae --info.extra dbl
#unbuffer python project.py a/double 3dshapes m/vae --info.extra b1-dbl --model.reg_wt 1
#unbuffer python project.py a/double 3dshapes m/vae --info.extra b4-dbl --model.reg_wt 4
#unbuffer python project.py a/double 3dshapes m/vae --info.extra b16-dbl --model.reg_wt 16



#unbuffer python project.py a/e/attn12 a/d/branch12 m/ae 3dshapes --info.extra 12b1-12h4k64v64-seed5-lr1 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64 --seed 5 --model.lr 0.0001
#unbuffer python project.py a/e/attn12 a/d/branch12 m/vae 3dshapes --info.extra b16-12b1-12h4k64v64-lr1 --model.reg_wt 16 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64 --model.lr 0.0001

#unbuffer python project.py a/e/attn12 a/d/branch12 m/ae 3dshapes --info.extra 12b1-12h4k64v64-seed5-lr2 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64 --seed 5 --model.lr 0.0002
#unbuffer python project.py a/e/attn12 a/d/branch12 m/vae 3dshapes --info.extra b16-12b1-12h4k64v64-lr2 --model.reg_wt 16 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64 --model.lr 0.0002

#unbuffer python project.py a/e/attn12 a/d/branch12 m/ae 3dshapes --info.extra 12b1-12h4k64v64-seed5-lr5 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64 --seed 5 --model.lr 0.0005
#unbuffer python project.py a/e/attn12 a/d/branch12 m/vae 3dshapes --info.extra b16-12b1-12h4k64v64-lr5 --model.reg_wt 16 --model.keys_per_head 4 --model.key_val_dim 128 --model.val_dim 64 --model.lr 0.0005


### 1

#unbuffer python project.py a/e/attn12 a/d/branch12 3dshapes m/ae --info.extra 12b1-12h1k64v64 --model.keys_per_head 1 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn12 a/d/branch12 3dshapes m/ae --info.extra 12b1-12h2k64v64 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn12 a/d/branch12 3dshapes m/ae --info.extra 12b1-12h4k64v64 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32

#unbuffer python project.py a/e/attn12 a/d/branch12 3dshapes m/ae --info.extra 12b1-12h1k64v64 --model.keys_per_head 1 --model.key_val_dim 128 --model.val_dim 64
#unbuffer python project.py a/e/attn12 a/d/branch12 3dshapes m/ae --info.extra 12b1-12h1k32v32 --model.keys_per_head 1 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn12 a/d/branch12 3dshapes m/ae --info.extra 12b1-12h1k16v16 --model.keys_per_head 1 --model.key_val_dim 32 --model.val_dim 16
#unbuffer python project.py a/e/attn12 a/d/branch12 3dshapes m/ae --info.extra 12b1-12h1k8v8 --model.keys_per_head 1 --model.key_val_dim 16 --model.val_dim 8

#unbuffer python project.py a/e/attn4 a/d/branch12 3dshapes m/ae --info.extra 12b1-4h1k32v32 --model.keys_per_head 1 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn6 a/d/branch12 3dshapes m/ae --info.extra 12b1-6h1k32v32 --model.keys_per_head 1 --model.key_val_dim 64 --model.val_dim 32


### 2

#unbuffer python project.py a/conv 3dshapes m/ae --info.extra conv
#unbuffer python project.py a/conv 3dshapes m/ae --info.extra b1-conv --model.reg_wt 1
#unbuffer python project.py a/conv 3dshapes m/wae --info.extra conv
#unbuffer python project.py a/conv 3dshapes m/vae --info.extra b1-conv --model.reg_wt 1
#unbuffer python project.py a/conv 3dshapes m/vae --info.extra b2-conv --model.reg_wt 2
#unbuffer python project.py a/conv 3dshapes m/vae --info.extra b4-conv --model.reg_wt 4
#unbuffer python project.py a/conv 3dshapes m/vae --info.extra b8-conv --model.reg_wt 8
#unbuffer python project.py a/conv 3dshapes m/vae --info.extra b16-conv --model.reg_wt 16
#unbuffer python project.py a/conv 3dshapes m/vae --info.extra b32-conv --model.reg_wt 32

### 3 


#unbuffer python project.py a/dislib 3dshapes m/ae --info.extra dislib
#unbuffer python project.py a/dislib 3dshapes m/ae --info.extra b1-dislib --model.reg_wt 1
#unbuffer python project.py a/dislib 3dshapes m/wae --info.extra dislib
#unbuffer python project.py a/dislib 3dshapes m/vae --info.extra b1-dislib --model.reg_wt 1
#unbuffer python project.py a/dislib 3dshapes m/vae --info.extra b2-dislib --model.reg_wt 2
#unbuffer python project.py a/dislib 3dshapes m/vae --info.extra b4-dislib --model.reg_wt 4
#unbuffer python project.py a/dislib 3dshapes m/vae --info.extra b8-dislib --model.reg_wt 8
#unbuffer python project.py a/dislib 3dshapes m/vae --info.extra b16-dislib --model.reg_wt 16
#unbuffer python project.py a/dislib 3dshapes m/vae --info.extra b32-dislib --model.reg_wt 32

### 4

#unbuffer python project.py a/double 3dshapes m/ae --info.extra dbl
#unbuffer python project.py a/double 3dshapes m/ae --info.extra b1-dbl --model.reg_wt 1
#unbuffer python project.py a/double 3dshapes m/wae --info.extra dbl
#unbuffer python project.py a/double 3dshapes m/vae --info.extra b1-dbl --model.reg_wt 1
#unbuffer python project.py a/double 3dshapes m/vae --info.extra b2-dbl --model.reg_wt 2
#unbuffer python project.py a/double 3dshapes m/vae --info.extra b4-dbl --model.reg_wt 4
#unbuffer python project.py a/double 3dshapes m/vae --info.extra b8-dbl --model.reg_wt 8
#unbuffer python project.py a/double 3dshapes m/vae --info.extra b16-dbl --model.reg_wt 16
#unbuffer python project.py a/double 3dshapes m/vae --info.extra b32-dbl --model.reg_wt 32

### 5

#unbuffer python project.py a/d/branch12 a/e/dislib 3dshapes m/ae --info.extra 12b1-dislib
#unbuffer python project.py a/d/branch12 a/e/conv 3dshapes m/ae --info.extra 12b1-conv
#unbuffer python project.py a/d/branch12 a/e/double 3dshapes m/ae --info.extra 12b1-dbl

### 6-7

#unbuffer python project.py a/d/branch12 a/e/lib-conv 3dshapes m/ae --info.extra 12b1-dislib

### 8 

#unbuffer python project.py a/dislib t/3ds-shapes m/ae --info.extra dislib
#unbuffer python project.py a/dislib t/3ds-shapes m/vae --info.extra b1-dislib --model.reg_wt 1
#unbuffer python project.py a/dislib t/3ds-shapes m/vae --info.extra b16-dislib --model.reg_wt 16

#unbuffer python project.py a/conv t/3ds-shapes m/ae --info.extra conv
#unbuffer python project.py a/conv t/3ds-shapes m/vae --info.extra b1-conv --model.reg_wt 1
#unbuffer python project.py a/conv t/3ds-shapes m/vae --info.extra b16-conv --model.reg_wt 16

#unbuffer python project.py a/double t/3ds-shapes m/ae --info.extra dbl
#unbuffer python project.py a/double m/vae t/3ds-shapes --info.extra b1-dbl --model.reg_wt 1
#unbuffer python project.py a/double m/vae t/3ds-shapes --info.extra b16-dbl --model.reg_wt 16

#unbuffer python project.py a/d/branch12 a/e/lib-conv t/3ds-shapes m/ae --info.extra 12b1-dislib
#unbuffer python project.py a/d/branch12 a/e/conv t/3ds-shapes m/ae --info.extra 12b1-conv
#unbuffer python project.py a/d/branch12 a/e/double t/3ds-shapes m/ae --info.extra 12b1-dbl

### 9

#unbuffer python project.py a/d/branch4 a/e/lib-conv 3dshapes m/ae --info.extra 4b3-dislib
#unbuffer python project.py a/d/branch4 a/e/conv 3dshapes m/ae --info.extra 4b3-conv
#unbuffer python project.py a/d/branch4 a/e/double 3dshapes m/ae --info.extra 4b3-dbl

#unbuffer python project.py a/d/branch6 a/e/lib-conv 3dshapes m/ae --info.extra 6b2-dislib
#unbuffer python project.py a/d/branch6 a/e/conv 3dshapes m/ae --info.extra 6b2-conv
#unbuffer python project.py a/d/branch6 a/e/double 3dshapes m/ae --info.extra 6b2-dbl

### 10

#unbuffer python project.py t/upd --load t3ds-shapes-ae-12b1-conv_0008-6337836-10_200509-130720
#unbuffer python project.py t/upd --load t3ds-shapes-vae-b16-dbl_0008-6337836-08_200509-130723
#unbuffer python project.py t/upd --load t3ds-shapes-ae-dbl_0008-6337836-06_200509-130725
#unbuffer python project.py t/upd --load t3ds-shapes-ae-conv_0008-6337836-03_200509-130726
#unbuffer python project.py t/upd --load t3ds-shapes-vae-b16-conv_0008-6337836-05_200509-130729
#unbuffer python project.py t/upd --load t3ds-shapes-vae-b1-dislib_0008-6337836-01_200509-130731
#unbuffer python project.py t/upd --load t3ds-shapes-vae-b1-conv_0008-6337836-04_200509-130733
#unbuffer python project.py t/upd --load t3ds-shapes-ae-dislib_0008-6337836-00_200509-130737
#unbuffer python project.py t/upd --load t3ds-shapes-vae-b16-dislib_0008-6337836-02_200509-130744
#unbuffer python project.py t/upd --load t3ds-shapes-ae-12b1-dislib_0008-6337836-09_200509-130759

### 11

#unbuffer python project.py a/conv mpi3d m/ae --dataset.category toy --info.extra conv
#unbuffer python project.py a/conv mpi3d m/ae --dataset.category toy --info.extra b1-conv --model.reg_wt 1
#unbuffer python project.py a/conv mpi3d m/wae --dataset.category toy --info.extra conv
#unbuffer python project.py a/conv mpi3d m/vae --dataset.category toy --info.extra b1-conv --model.reg_wt 1
#unbuffer python project.py a/conv mpi3d m/vae --dataset.category toy --info.extra b2-conv --model.reg_wt 2
#unbuffer python project.py a/conv mpi3d m/vae --dataset.category toy --info.extra b4-conv --model.reg_wt 4
#unbuffer python project.py a/conv mpi3d m/vae --dataset.category toy --info.extra b8-conv --model.reg_wt 8
#unbuffer python project.py a/conv mpi3d m/vae --dataset.category toy --info.extra b16-conv --model.reg_wt 16

#unbuffer python project.py a/d/branch12 a/e/lib-conv mpi3d m/ae --dataset.category toy --info.extra 12b1-dislib
#unbuffer python project.py a/d/branch12 a/e/conv mpi3d m/ae --dataset.category toy --info.extra 12b1-conv
#unbuffer python project.py a/d/branch12 a/e/double mpi3d m/ae --dataset.category toy --info.extra 12b1-dbl

### 12

#unbuffer python project.py a/conv mpi3d m/ae --dataset.category real --info.extra conv
#unbuffer python project.py a/conv mpi3d m/ae --dataset.category real --info.extra b1-conv --model.reg_wt 1
#unbuffer python project.py a/conv mpi3d m/wae --dataset.category real --info.extra conv
#unbuffer python project.py a/conv mpi3d m/vae --dataset.category real --info.extra b1-conv --model.reg_wt 1
#unbuffer python project.py a/conv mpi3d m/vae --dataset.category real --info.extra b2-conv --model.reg_wt 2
#unbuffer python project.py a/conv mpi3d m/vae --dataset.category real --info.extra b4-conv --model.reg_wt 4
#unbuffer python project.py a/conv mpi3d m/vae --dataset.category real --info.extra b8-conv --model.reg_wt 8
#unbuffer python project.py a/conv mpi3d m/vae --dataset.category real --info.extra b16-conv --model.reg_wt 16

#unbuffer python project.py a/d/branch12 a/e/lib-conv mpi3d m/ae --dataset.category real --info.extra 12b1-dislib
#unbuffer python project.py a/d/branch12 a/e/conv mpi3d m/ae --dataset.category real --info.extra 12b1-conv
#unbuffer python project.py a/d/branch12 a/e/double mpi3d m/ae --dataset.category real --info.extra 12b1-dbl

### 13

#unbuffer python project.py a/e/attn12 a/d/branch12 mpi3d m/ae --dataset.category toy --info.extra 12b1-12h1k64v64 --model.keys_per_head 1 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn12 a/d/branch12 mpi3d m/ae --dataset.category toy --info.extra 12b1-12h2k64v64 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn12 a/d/branch12 mpi3d m/ae --dataset.category toy --info.extra 12b1-12h4k64v64 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32

#unbuffer python project.py a/e/attn12 a/d/branch12 mpi3d m/ae --dataset.category toy --info.extra 12b1-12h1k64v64 --model.keys_per_head 1 --model.key_val_dim 128 --model.val_dim 64
#unbuffer python project.py a/e/attn12 a/d/branch12 mpi3d m/ae --dataset.category toy --info.extra 12b1-12h1k32v32 --model.keys_per_head 1 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn12 a/d/branch12 mpi3d m/ae --dataset.category toy --info.extra 12b1-12h1k16v16 --model.keys_per_head 1 --model.key_val_dim 32 --model.val_dim 16
#unbuffer python project.py a/e/attn12 a/d/branch12 mpi3d m/ae --dataset.category toy --info.extra 12b1-12h1k8v8 --model.keys_per_head 1 --model.key_val_dim 16 --model.val_dim 8

#unbuffer python project.py a/e/attn4 a/d/branch12 mpi3d m/ae --dataset.category toy --info.extra 12b1-4h1k32v32 --model.keys_per_head 1 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn6 a/d/branch12 mpi3d m/ae --dataset.category toy --info.extra 12b1-6h1k32v32 --model.keys_per_head 1 --model.key_val_dim 64 --model.val_dim 32

### 14

#unbuffer python project.py --resume mpi3d-ae-12b1-12h1k32v32_0013-6343740-04_200512-014614
#unbuffer python project.py --resume mpi3d-ae-12b1-4h1k32v32_0013-6343740-07_200512-014605
#unbuffer python project.py --resume mpi3d-ae-12b1-12h2k64v64_0013-6343740-01_200512-014606
#unbuffer python project.py --resume mpi3d-ae-12b1-12h1k64v64_0013-6343740-03_200512-014607
#unbuffer python project.py --resume mpi3d-ae-12b1-12h1k64v64_0013-6343740-00_200512-014607
#unbuffer python project.py --resume mpi3d-ae-12b1-12h1k8v8_0013-6343740-06_200512-014641

### 15

#unbuffer python project.py a/e/attn12 a/d/branch12 mpi3d m/ae --dataset.category real --info.extra 12b1-12h1k64v64 --model.keys_per_head 1 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn12 a/d/branch12 mpi3d m/ae --dataset.category real --info.extra 12b1-12h2k64v64 --model.keys_per_head 2 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn12 a/d/branch12 mpi3d m/ae --dataset.category real --info.extra 12b1-12h4k64v64 --model.keys_per_head 4 --model.key_val_dim 64 --model.val_dim 32

#unbuffer python project.py a/e/attn12 a/d/branch12 mpi3d m/ae --dataset.category real --info.extra 12b1-12h1k64v64 --model.keys_per_head 1 --model.key_val_dim 128 --model.val_dim 64
#unbuffer python project.py a/e/attn12 a/d/branch12 mpi3d m/ae --dataset.category real --info.extra 12b1-12h1k32v32 --model.keys_per_head 1 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn12 a/d/branch12 mpi3d m/ae --dataset.category real --info.extra 12b1-12h1k16v16 --model.keys_per_head 1 --model.key_val_dim 32 --model.val_dim 16
#unbuffer python project.py a/e/attn12 a/d/branch12 mpi3d m/ae --dataset.category real --info.extra 12b1-12h1k8v8 --model.keys_per_head 1 --model.key_val_dim 16 --model.val_dim 8

#unbuffer python project.py a/e/attn4 a/d/branch12 mpi3d m/ae --dataset.category real --info.extra 12b1-4h1k32v32 --model.keys_per_head 1 --model.key_val_dim 64 --model.val_dim 32
#unbuffer python project.py a/e/attn6 a/d/branch12 mpi3d m/ae --dataset.category real --info.extra 12b1-6h1k32v32 --model.keys_per_head 1 --model.key_val_dim 64 --model.val_dim 32

### 16

#unbuffer python project.py a/dislib t/mpi-shapes m/ae --info.extra dislib
#unbuffer python project.py a/dislib t/mpi-shapes m/vae --info.extra b1-dislib --model.reg_wt 1
#unbuffer python project.py a/dislib t/mpi-shapes m/vae --info.extra b16-dislib --model.reg_wt 16

#unbuffer python project.py a/conv t/mpi-shapes m/ae --info.extra conv
#unbuffer python project.py a/conv t/mpi-shapes m/vae --info.extra b1-conv --model.reg_wt 1
#unbuffer python project.py a/conv t/mpi-shapes m/vae --info.extra b16-conv --model.reg_wt 16

#unbuffer python project.py a/double t/mpi-shapes m/ae --info.extra dbl
#unbuffer python project.py a/double t/mpi-shapes m/vae --info.extra b1-dbl --model.reg_wt 1
#unbuffer python project.py a/double t/mpi-shapes m/vae --info.extra b16-dbl --model.reg_wt 16

#unbuffer python project.py a/d/branch12 a/e/lib-conv t/mpi-shapes m/ae --info.extra 12b1-dislib
#unbuffer python project.py a/d/branch12 a/e/conv t/mpi-shapes m/ae --info.extra 12b1-conv
#unbuffer python project.py a/d/branch12 a/e/double t/mpi-shapes m/ae --info.extra 12b1-dbl


### 17

#unbuffer python project.py t/upd --load tmpi-shapes-vae-b1-dbl_0016-6346981-07_200513-040929
#unbuffer python project.py t/upd --load tmpi-shapes-vae-b1-conv_0016-6346981-04_200513-040930
#unbuffer python project.py t/upd --load tmpi-shapes-vae-b16-conv_0016-6346981-05_200513-040930
#unbuffer python project.py t/upd --load tmpi-shapes-ae-conv_0016-6346981-03_200513-040931

#unbuffer python project.py t/upd --load tmpi-shapes-vae-b1-dislib_0016-6346981-01_200513-040931
#unbuffer python project.py t/upd --load tmpi-shapes-vae-b16-dbl_0016-6346981-08_200513-040932
#unbuffer python project.py t/upd --load tmpi-shapes-ae-dbl_0016-6346981-06_200513-040932

#unbuffer python project.py t/upd --load tmpi-shapes-ae-12b1-conv_0016-6346981-10_200513-040939
#unbuffer python project.py t/upd --load tmpi-shapes-ae-dislib_0016-6346981-00_200513-040941
#unbuffer python project.py t/upd --load tmpi-shapes-vae-b16-dislib_0016-6346981-02_200513-040941

### 18

#unbuffer python project.py a/dislib t/mpi-shapes m/ae --info.extra dislib
#unbuffer python project.py a/dislib t/mpi-shapes m/vae --info.extra b1-dislib --model.reg_wt 1
#unbuffer python project.py a/dislib t/mpi-shapes m/vae --info.extra b2-dislib --model.reg_wt 2

#unbuffer python project.py a/conv t/mpi-shapes m/ae --info.extra conv
#unbuffer python project.py a/conv t/mpi-shapes m/vae --info.extra b1-conv --model.reg_wt 1
#unbuffer python project.py a/conv t/mpi-shapes m/vae --info.extra b2-conv --model.reg_wt 2

#unbuffer python project.py a/double t/mpi-shapes m/ae --info.extra dbl
#unbuffer python project.py a/double t/mpi-shapes m/vae --info.extra b1-dbl --model.reg_wt 1
#unbuffer python project.py a/double t/mpi-shapes m/vae --info.extra b2-dbl --model.reg_wt 2

#unbuffer python project.py a/d/branch12 a/e/lib-conv t/mpi-shapes m/ae --info.extra 12b1-dislib
#unbuffer python project.py a/d/branch12 a/e/conv t/mpi-shapes m/ae --info.extra 12b1-conv
#unbuffer python project.py a/d/branch12 a/e/double t/mpi-shapes m/ae --info.extra 12b1-dbl


################

### 19

#unbuffer python project.py a/d/branch12 a/e/conv t/mpi-sizes m/ae --info.extra toy-12b1-conv
#unbuffer python project.py a/conv t/mpi-sizes m/vae --dataset.category toy --info.extra toy-b2-conv --model.reg_wt 2
#unbuffer python project.py a/dislib t/mpi-sizes m/vae --dataset.category toy --info.extra toy-b2-dislib --model.reg_wt 2

#unbuffer python project.py a/dislib t/mpi-sizes m/ae --dataset.category toy --info.extra toy-dislib
#unbuffer python project.py a/dislib t/mpi-sizes m/vae --dataset.category toy --info.extra toy-b1-dislib --model.reg_wt 1

#unbuffer python project.py a/conv t/mpi-sizes m/ae --dataset.category toy --info.extra toy-conv
#unbuffer python project.py a/conv t/mpi-sizes m/vae --dataset.category toy --info.extra toy-b1-conv --model.reg_wt 1

#unbuffer python project.py a/d/branch12 a/e/conv t/mpi-sizes m/ae --info.extra toy-12b1-conv-s2 --seed 2
#unbuffer python project.py a/conv t/mpi-sizes m/vae --dataset.category toy --info.extra toy-b2-conv-s2 --model.reg_wt 2 --seed 2
#unbuffer python project.py a/dislib t/mpi-sizes m/vae --dataset.category toy --info.extra toy-b2-dislib-s2 --model.reg_wt 2 --seed 2

### 20,25

#unbuffer python project.py a/d/branch12 a/e/conv t/mpi-shapes m/ae --info.extra toy-12b1-conv
#unbuffer python project.py a/conv t/mpi-shapes m/vae --dataset.category toy --info.extra toy-b2-conv --model.reg_wt 2
#unbuffer python project.py a/dislib t/mpi-shapes m/vae --dataset.category toy --info.extra toy-b2-dislib --model.reg_wt 2

#unbuffer python project.py a/dislib t/mpi-shapes m/ae --dataset.category toy --info.extra toy-dislib
#unbuffer python project.py a/dislib t/mpi-shapes m/vae --dataset.category toy --info.extra toy-b1-dislib --model.reg_wt 1

#unbuffer python project.py a/conv t/mpi-shapes m/ae --dataset.category toy --info.extra toy-conv
#unbuffer python project.py a/conv t/mpi-shapes m/vae --dataset.category toy --info.extra toy-b1-conv --model.reg_wt 1

#unbuffer python project.py a/d/branch12 a/e/conv t/mpi-shapes m/ae --info.extra toy-12b1-conv-s2 --seed 2
#unbuffer python project.py a/conv t/mpi-shapes m/vae --dataset.category toy --info.extra toy-b2-conv-s2 --model.reg_wt 2 --seed 2
#unbuffer python project.py a/dislib t/mpi-shapes m/vae --dataset.category toy --info.extra toy-b2-dislib-s2 --model.reg_wt 2 --seed 2

### 21,23

#unbuffer python project.py a/d/branch12 a/e/conv t/mpi-sizes m/ae --dataset.category real --info.extra real-12b1-conv
#unbuffer python project.py a/conv t/mpi-sizes m/vae --dataset.category real --info.extra real-b2-conv --model.reg_wt 2
#unbuffer python project.py a/dislib t/mpi-sizes m/vae --dataset.category real --info.extra real-b2-dislib --model.reg_wt 2

#unbuffer python project.py a/dislib t/mpi-sizes m/ae --dataset.category real --info.extra real-dislib
#unbuffer python project.py a/dislib t/mpi-sizes m/vae --dataset.category real --info.extra real-b1-dislib --model.reg_wt 1

#unbuffer python project.py a/conv t/mpi-sizes m/ae --dataset.category real --info.extra real-conv
#unbuffer python project.py a/conv t/mpi-sizes m/vae --dataset.category real --info.extra real-b1-conv --model.reg_wt 1

#unbuffer python project.py a/d/branch12 a/e/conv t/mpi-sizes m/ae --info.extra real-12b1-conv-s2 --seed 2
#unbuffer python project.py a/conv t/mpi-sizes m/vae --dataset.category real --info.extra real-b2-conv-s2 --model.reg_wt 2 --seed 2
#unbuffer python project.py a/dislib t/mpi-sizes m/vae --dataset.category real --info.extra real-b2-dislib-s2 --model.reg_wt 2 --seed 2

### 22,24

#unbuffer python project.py a/d/branch12 a/e/conv t/mpi-shapes m/ae --dataset.category real --info.extra real-12b1-conv
#unbuffer python project.py a/conv t/mpi-shapes m/vae --dataset.category real --info.extra real-b2-conv --model.reg_wt 2
#unbuffer python project.py a/dislib t/mpi-shapes m/vae --dataset.category real --info.extra real-b2-dislib --model.reg_wt 2

#unbuffer python project.py a/dislib t/mpi-shapes m/ae --dataset.category real --info.extra real-dislib
#unbuffer python project.py a/dislib t/mpi-shapes m/vae --dataset.category real --info.extra real-b1-dislib --model.reg_wt 1

#unbuffer python project.py a/conv t/mpi-shapes m/ae --dataset.category real --info.extra real-conv
#unbuffer python project.py a/conv t/mpi-shapes m/vae --dataset.category real --info.extra real-b1-conv --model.reg_wt 1

#unbuffer python project.py a/d/branch12 a/e/conv t/mpi-shapes m/ae --info.extra real-12b1-conv-s2 --seed 2
#unbuffer python project.py a/conv t/mpi-shapes m/vae --dataset.category real --info.extra real-b2-conv-s2 --model.reg_wt 2 --seed 2
#unbuffer python project.py a/dislib t/mpi-shapes m/vae --dataset.category real --info.extra real-b2-dislib-s2 --model.reg_wt 2 --seed 2

### 26

#unbuffer python project.py t/upd --load tmpi-sizes-ae-toy-12b1-conv_0019-6352187-00_200516-020124
#unbuffer python project.py t/upd --load tmpi-sizes-vae-toy-b2-conv_0019-6352187-01_200516-020229
#unbuffer python project.py t/upd --load tmpi-sizes-vae-toy-b2-dislib_0019-6352187-02_200516-020402
#unbuffer python project.py t/upd --load tmpi-sizes-ae-toy-dislib_0019-6352187-03_200516-020510
#unbuffer python project.py t/upd --load tmpi-sizes-vae-toy-b1-dislib_0019-6352187-04_200516-020653

#unbuffer python project.py t/upd --load tmpi-sizes-ae-toy-conv_0019-6352187-05_200516-020656
#unbuffer python project.py t/upd --load tmpi-sizes-vae-toy-b1-conv_0019-6352187-06_200516-021559
#unbuffer python project.py t/upd --load tmpi-sizes-ae-toy-12b1-conv-s2_0019-6352187-07_200516-021651
#unbuffer python project.py t/upd --load tmpi-sizes-vae-toy-b2-conv-s2_0019-6352187-08_200516-021903
#unbuffer python project.py t/upd --load tmpi-sizes-vae-toy-b2-dislib-s2_0019-6352187-09_200516-021927

### 27

#unbuffer python project.py t/upd --load tmpi-sizes-ae-real-12b1-conv_0023-6352332-00_200516-042131
#unbuffer python project.py t/upd --load tmpi-sizes-vae-real-b2-conv_0023-6352332-01_200516-042315
#unbuffer python project.py t/upd --load tmpi-sizes-ae-real-dislib_0023-6352332-03_200516-042813
#unbuffer python project.py t/upd --load tmpi-sizes-vae-real-b2-dislib_0023-6352332-02_200516-042814
#unbuffer python project.py t/upd --load tmpi-sizes-ae-real-conv_0023-6352332-05_200516-042840

#unbuffer python project.py t/upd --load tmpi-sizes-vae-real-b1-dislib_0023-6352332-04_200516-042840
#unbuffer python project.py t/upd --load tmpi-sizes-vae-real-b1-conv_0023-6352332-06_200516-044716
#unbuffer python project.py t/upd --load tmpi-sizes-ae-real-12b1-conv-s2_0023-6352332-07_200516-044716
#unbuffer python project.py t/upd --load tmpi-sizes-vae-real-b2-dislib-s2_0023-6352332-09_200516-044909
#unbuffer python project.py t/upd --load tmpi-sizes-vae-real-b2-conv-s2_0023-6352332-08_200516-044910

### 28

#unbuffer python project.py t/upd --load tmpi-shapes-ae-real-12b1-conv_0024-6352333-00_200516-045012
#unbuffer python project.py t/upd --load tmpi-shapes-vae-real-b2-conv_0024-6352333-01_200516-045110
#unbuffer python project.py t/upd --load tmpi-shapes-ae-real-dislib_0024-6352333-03_200516-045408
#unbuffer python project.py t/upd --load tmpi-shapes-vae-real-b1-dislib_0024-6352333-04_200516-045409
#unbuffer python project.py t/upd --load tmpi-shapes-vae-real-b2-dislib_0024-6352333-02_200516-045414

#unbuffer python project.py t/upd --load tmpi-shapes-ae-real-conv_0024-6352333-05_200516-045535
#unbuffer python project.py t/upd --load tmpi-shapes-vae-real-b1-conv_0024-6352333-06_200516-052106
#unbuffer python project.py t/upd --load tmpi-shapes-ae-real-12b1-conv-s2_0024-6352333-07_200516-052916
#unbuffer python project.py t/upd --load tmpi-shapes-vae-real-b2-conv-s2_0024-6352333-08_200516-060720
#unbuffer python project.py t/upd --load tmpi-shapes-vae-real-b2-dislib-s2_0024-6352333-09_200516-065914

### 29

#unbuffer python project.py t/upd --load tmpi-shapes-ae-toy-12b1-conv_0025-6352334-00_200516-065917
#unbuffer python project.py t/upd --load tmpi-shapes-vae-toy-b2-conv_0025-6352334-01_200516-070414
#unbuffer python project.py t/upd --load tmpi-shapes-vae-toy-b2-dislib_0025-6352334-02_200516-071120
#unbuffer python project.py t/upd --load tmpi-shapes-ae-toy-dislib_0025-6352334-03_200516-073329
#unbuffer python project.py t/upd --load tmpi-shapes-vae-toy-b1-dislib_0025-6352334-04_200516-073618

#unbuffer python project.py t/upd --load tmpi-shapes-ae-toy-conv_0025-6352334-05_200516-080143
#unbuffer python project.py t/upd --load tmpi-shapes-vae-toy-b1-conv_0025-6352334-06_200516-080145
#unbuffer python project.py t/upd --load tmpi-shapes-ae-toy-12b1-conv-s2_0025-6352334-07_200516-081525
#unbuffer python project.py t/upd --load tmpi-shapes-vae-toy-b2-conv-s2_0025-6352334-08_200516-081917
#unbuffer python project.py t/upd --load tmpi-shapes-vae-toy-b2-dislib-s2_0025-6352334-09_200516-083245


### 30 

#unbuffer python project.py long a/d/lbranch12 a/e/conv mpi3d m/ae --info.extra l-toy-12b1-conv
#unbuffer python project.py long a/lconv mpi3d m/vae --dataset.category toy --info.extra l-toy-b2-conv --model.reg_wt 2

#unbuffer python project.py long a/lconv mpi3d m/ae --dataset.category toy --info.extra l-toy-conv
#unbuffer python project.py long a/lconv mpi3d m/vae --dataset.category toy --info.extra l-toy-b1-conv --model.reg_wt 1
#unbuffer python project.py long a/lconv mpi3d m/vae --dataset.category toy --info.extra l-toy-b4-conv --model.reg_wt 4

#unbuffer python project.py long a/d/lbranch12 a/e/lconv mpi3d m/ae --info.extra l-toy-12b1-conv-s2 --seed 2
#unbuffer python project.py long a/lconv mpi3d m/vae --dataset.category toy --info.extra l-toy-b2-conv-s2 --model.reg_wt 2 --seed 2

### 31

#unbuffer python project.py a/d/dbranch12 a/e/dconv celeba m/ae --info.extra 12b1-conv
#unbuffer python project.py a/deep celeba m/vae --info.extra b2-conv --model.reg_wt 2

#unbuffer python project.py a/deep celeba m/ae --info.extra conv
#unbuffer python project.py a/deep celeba m/wae --info.extra conv
#unbuffer python project.py a/deep celeba m/vae --info.extra b1-conv --model.reg_wt 1
#unbuffer python project.py a/deep celeba m/vae --info.extra b4-conv --model.reg_wt 4
#unbuffer python project.py a/deep celeba m/vae --info.extra b16-conv --model.reg_wt 16

#unbuffer python project.py a/d/dbranch12 a/e/dconv celeba m/ae --info.extra 12b1-conv-s2 --seed 2
#unbuffer python project.py a/deep celeba m/vae --info.extra b2-conv-s2 --model.reg_wt 2 --seed 2

### 32

#unbuffer python project.py long a/d/lbranch12 a/e/conv mpi3d m/ae --dataset.category real --info.extra l-toy-12b1-conv
#unbuffer python project.py long a/lconv mpi3d m/vae --dataset.category real --info.extra l-toy-b2-conv --model.reg_wt 2

#unbuffer python project.py long a/lconv mpi3d m/ae --dataset.category real --info.extra l-toy-conv
#unbuffer python project.py long a/lconv mpi3d m/vae --dataset.category real --info.extra l-toy-b1-conv --model.reg_wt 1
#unbuffer python project.py long a/lconv mpi3d m/vae --dataset.category real --info.extra l-toy-b4-conv --model.reg_wt 4

#unbuffer python project.py long a/d/lbranch12 a/e/lconv mpi3d m/ae --dataset.category real --info.extra l-toy-12b1-conv-s2 --seed 2
#unbuffer python project.py long a/lconv mpi3d m/vae --dataset.category real --info.extra l-toy-b2-conv-s2 --model.reg_wt 2 --seed 2


### 33

#unbuffer python project.py a/d/branch12 a/e/conv 3dshapes m/ae --info.extra 12b1-conv --seed 3
#unbuffer python project.py a/d/branch12 a/e/conv 3dshapes m/ae --info.extra 12b1-conv --seed 4

### 34

#unbuffer python project.py a/d/branch4 a/e/conv 3dshapes m/ae --info.extra 4b3-conv
#unbuffer python project.py a/d/branch6 a/e/conv 3dshapes m/ae --info.extra 6b2-conv

#unbuffer python project.py a/d/branch4 a/e/conv 3dshapes m/ae --info.extra 4b3-conv-s2 --seed 2
#unbuffer python project.py a/d/branch6 a/e/conv 3dshapes m/ae --info.extra 6b2-conv-s2 --seed 2
#unbuffer python project.py a/d/branch12 a/e/conv 3dshapes m/ae --info.extra 12b1-conv-s2 --seed 2

### 35

#unbuffer python project.py --resume celeba-ae-12b1-conv_0031-6362398-00_200517-170612

### 36

#unbuffer python project.py a/d/branch4 a/e/conv t/mpi-shapes m/ae --dataset.category real --info.extra real-4b3-conv
#unbuffer python project.py a/d/branch6 a/e/conv t/mpi-shapes m/ae --dataset.category real --info.extra real-6b2-conv
#unbuffer python project.py a/dislib t/mpi-shapes m/wae --dataset.category real --info.extra real-dislib
#unbuffer python project.py a/conv t/mpi-shapes m/wae --dataset.category real --info.extra real-conv

#unbuffer python project.py a/d/branch4 a/e/conv t/mpi-shapes m/ae --dataset.category toy --info.extra toy-4b3-conv
#unbuffer python project.py a/d/branch6 a/e/conv t/mpi-shapes m/ae --dataset.category toy --info.extra toy-6b2-conv
#unbuffer python project.py a/dislib t/mpi-shapes m/wae --dataset.category toy --info.extra toy-dislib
#unbuffer python project.py a/conv t/mpi-shapes m/wae --dataset.category toy --info.extra toy-conv

#unbuffer python project.py a/d/branch4 a/e/conv t/3ds-shapes m/ae --info.extra 4b3-conv
#unbuffer python project.py a/d/branch6 a/e/conv t/3ds-shapes m/ae --info.extra 6b2-conv
#unbuffer python project.py a/dislib t/3ds-shapes m/wae --info.extra dislib
#unbuffer python project.py a/conv t/3ds-shapes m/wae --info.extra conv

### 37-38

#unbuffer python project.py resbranch a/d/dbranch12 a/e/dconv celeba m/ae --info.extra r12b1-conv

#unbuffer python project.py resbranch a/d/branch12 a/e/conv 3dshapes m/ae --info.extra r12b1-conv
#unbuffer python project.py resbranch a/d/branch6 a/e/conv 3dshapes m/ae --info.extra r6b2-conv
#unbuffer python project.py resbranch a/d/branch4 a/e/conv 3dshapes m/ae --info.extra r4b3-conv

#unbuffer python project.py resbranch a/d/branch12 a/e/conv mpi3d m/ae --dataset.category toy --info.extra toy-r12b1-conv
#unbuffer python project.py resbranch a/d/branch6 a/e/conv mpi3d m/ae --dataset.category toy --info.extra toy-r6b2-conv
#unbuffer python project.py resbranch a/d/branch4 a/e/conv mpi3d m/ae --dataset.category toy --info.extra toy-r4b3-conv

#unbuffer python project.py resbranch a/d/branch12 a/e/conv mpi3d m/ae --dataset.category real --info.extra real-r12b1-conv
#unbuffer python project.py resbranch a/d/branch6 a/e/conv mpi3d m/ae --dataset.category real --info.extra real-r6b2-conv
#unbuffer python project.py resbranch a/d/branch4 a/e/conv mpi3d m/ae --dataset.category real --info.extra real-r4b3-conv

### 39

#unbuffer python project.py a/d/branch12 a/e/attn12 t/3ds-shapes m/ae --info.extra 12b1-12h-conv
#unbuffer python project.py a/d/branch12 a/e/attn6 t/3ds-shapes m/ae --info.extra 12b1-6h-conv
#unbuffer python project.py a/d/branch12 a/e/attn4 t/3ds-shapes m/ae --info.extra 12b1-4h-conv

#unbuffer python project.py a/d/branch12 a/e/attn12 t/mpi-shapes m/ae --dataset.category toy --info.extra toy-12b1-12h-conv
#unbuffer python project.py a/d/branch12 a/e/attn6 t/mpi-shapes m/ae --dataset.category toy --info.extra toy-12b1-6h-conv
#unbuffer python project.py a/d/branch12 a/e/attn4 t/mpi-shapes m/ae --dataset.category toy --info.extra toy-12b1-4h-conv

#unbuffer python project.py a/d/branch12 a/e/attn12 t/mpi-shapes m/ae --dataset.category real --info.extra real-12b1-12h-conv
#unbuffer python project.py a/d/branch12 a/e/attn6 t/mpi-shapes m/ae --dataset.category real --info.extra real-12b1-6h-conv
#unbuffer python project.py a/d/branch12 a/e/attn4 t/mpi-shapes m/ae --dataset.category real --info.extra real-12b1-4h-conv

### 40

#unbuffer python project.py t/upd --load tmpi-shapes-ae-real-4b3-conv_0036-6424644-00_200521-041456
#unbuffer python project.py t/upd --load tmpi-shapes-ae-real-6b2-conv_0036-6424644-01_200521-041505
#unbuffer python project.py t/upd --load tmpi-shapes-wae-real-conv_0036-6424644-03_200521-041510
#unbuffer python project.py t/upd --load tmpi-shapes-wae-real-dislib_0036-6424644-02_200521-041518

#unbuffer python project.py t/upd --load tmpi-shapes-wae-toy-conv_0036-6424644-07_200521-041512
#unbuffer python project.py t/upd --load tmpi-shapes-wae-toy-dislib_0036-6424644-06_200521-041517
#unbuffer python project.py t/upd --load tmpi-shapes-ae-toy-6b2-conv_0036-6424644-05_200521-041517
#unbuffer python project.py t/upd --load tmpi-shapes-ae-toy-4b3-conv_0036-6424644-04_200521-041527

#unbuffer python project.py t/upd --load t3ds-shapes-ae-4b3-conv_0036-6424644-08_200521-042709
#unbuffer python project.py t/upd --load t3ds-shapes-ae-6b2-conv_0036-6424644-09_200521-042750
#unbuffer python project.py t/upd --load t3ds-shapes-wae-dislib_0036-6424644-10_200521-043552
#unbuffer python project.py t/upd --load t3ds-shapes-wae-conv_0036-6424644-11_200521-045803

### 41

#unbuffer python project.py a/ladder4 3dshapes m/ae --info.extra lddr4
#unbuffer python project.py a/ladder6 3dshapes m/ae --info.extra lddr6
#unbuffer python project.py a/ladder12 3dshapes m/ae --info.extra lddr12

#unbuffer python project.py a/ladder4 3dshapes m/vae --info.extra lddr4
#unbuffer python project.py a/ladder6 3dshapes m/vae --info.extra lddr6
#unbuffer python project.py a/ladder12 3dshapes m/vae --info.extra lddr12

#unbuffer python project.py a/ladder4 mpi3d m/ae --dataset.category toy --info.extra lddr4
#unbuffer python project.py a/ladder6 mpi3d m/ae --dataset.category toy --info.extra lddr6
#unbuffer python project.py a/ladder12 mpi3d m/ae --dataset.category toy --info.extra lddr12

#unbuffer python project.py a/ladder4 mpi3d m/vae --dataset.category toy --info.extra lddr4
#unbuffer python project.py a/ladder6 mpi3d m/vae --dataset.category toy --info.extra lddr6
#unbuffer python project.py a/ladder12 mpi3d m/vae --dataset.category toy --info.extra lddr12

### 42


#unbuffer python project.py a/ladder12 3dshapes m/ae --info.extra r-lddrev12 --model.residual_core
#unbuffer python project.py a/dladder16 celeba m/vae --info.extra lddrev12

#unbuffer python project.py a/ladder4 3dshapes m/ae --info.extra lddrev4
#unbuffer python project.py a/ladder6 3dshapes m/ae --info.extra lddrev6
#unbuffer python project.py a/ladder12 3dshapes m/ae --info.extra lddrev12

#unbuffer python project.py a/ladder4 3dshapes m/vae --info.extra lddrev4
#unbuffer python project.py a/ladder6 3dshapes m/vae --info.extra lddrev6
#unbuffer python project.py a/ladder12 3dshapes m/vae --info.extra lddrev12

#unbuffer python project.py a/ladder4 mpi3d m/ae --dataset.category toy --info.extra lddrev4
#unbuffer python project.py a/ladder6 mpi3d m/ae --dataset.category toy --info.extra lddrev6
#unbuffer python project.py a/ladder12 mpi3d m/ae --dataset.category toy --info.extra lddrev12

#unbuffer python project.py a/ladder4 mpi3d m/vae --dataset.category toy --info.extra lddrev4
#unbuffer python project.py a/ladder6 mpi3d m/vae --dataset.category toy --info.extra lddrev6
#unbuffer python project.py a/ladder12 mpi3d m/vae --dataset.category toy --info.extra lddrev12

### 43

#unbuffer python project.py a/ladder16 celeba m/vae --info.extra lddrev12

### 44

#unbuffer python project.py t/upd --load t3ds-shapes-ae-12b1-12h-conv_0039-6425005-00_200521-150816
#unbuffer python project.py t/upd --load t3ds-shapes-ae-12b1-6h-conv_0039-6425005-01_200521-150812
#unbuffer python project.py t/upd --load t3ds-shapes-ae-12b1-4h-conv_0039-6425005-02_200521-150810

#unbuffer python project.py t/upd --load tmpi-shapes-ae-toy-12b1-12h-conv_0039-6425005-03_200521-150814
#unbuffer python project.py t/upd --load tmpi-shapes-ae-toy-12b1-4h-conv_0039-6425005-05_200521-165857

#unbuffer python project.py t/upd --load tmpi-shapes-ae-real-12b1-12h-conv_0039-6425005-06_200521-165855
#unbuffer python project.py t/upd --load tmpi-shapes-ae-real-12b1-6h-conv_0039-6425005-07_200521-181623
#unbuffer python project.py t/upd --load tmpi-shapes-ae-real-12b1-4h-conv_0039-6425005-08_200521-181701

### 45

#unbuffer python project.py t/test --load t3ds-shapes-ae-12b1-conv_0010-6339705-00_200509-233443
#unbuffer python project.py t/test --load t3ds-shapes-ae-conv_0010-6339705-03_200509-233342
#unbuffer python project.py t/test --load t3ds-shapes-vae-b1-conv_0010-6339705-06_200509-233330
#unbuffer python project.py t/test --load t3ds-shapes-vae-b16-conv_0010-6339705-04_200509-233331
#unbuffer python project.py t/test --load t3ds-shapes-ae-6b2-conv_0040-6457811-09_200521-192043
#unbuffer python project.py t/test --load t3ds-shapes-ae-4b3-conv_0040-6457811-08_200521-190411

### 46

#unbuffer python project.py t/test --load tmpi-shapes-ae-toy-conv_0029-6357652-05_200517-020945
#unbuffer python project.py t/test --load tmpi-shapes-vae-toy-b1-conv_0029-6357652-06_200517-021252
#unbuffer python project.py t/test --load tmpi-shapes-vae-toy-b2-conv_0029-6357652-01_200517-015851
#unbuffer python project.py t/test --load tmpi-shapes-ae-toy-12b1-conv_0029-6357652-00_200517-021120
#unbuffer python project.py t/test --load tmpi-shapes-ae-toy-6b2-conv_0040-6457811-06_200521-185626
#unbuffer python project.py t/test --load tmpi-shapes-ae-toy-4b3-conv_0040-6457811-07_200521-190415

### 47

#unbuffer python project.py t/test --load tmpi-shapes-ae-real-conv_0028-6357651-05_200517-013845
#unbuffer python project.py t/test --load tmpi-shapes-vae-real-b1-conv_0028-6357651-06_200517-014147
#unbuffer python project.py t/test --load tmpi-shapes-vae-real-b2-conv_0028-6357651-01_200517-013344
#unbuffer python project.py t/test --load tmpi-shapes-ae-real-12b1-conv_0028-6357651-00_200517-013342
#unbuffer python project.py t/test --load tmpi-shapes-ae-real-6b2-conv_0040-6457811-01_200521-181822
#unbuffer python project.py t/test --load tmpi-shapes-ae-real-4b3-conv_0040-6457811-00_200521-181732

### 48

#unbuffer python project.py a/ladder4 mpi3d m/vae --dataset.category real --info.extra real-lddrev4
#unbuffer python project.py a/ladder6 mpi3d m/vae --dataset.category real --info.extra real-lddrev6
#unbuffer python project.py a/ladder12 mpi3d m/vae --dataset.category real --info.extra real-lddrev12

### 49

#unbuffer python project.py t/test --load t3ds-shapes-ae-dislib_0010-6339705-07_200509-233331
#unbuffer python project.py t/test --load t3ds-shapes-vae-b1-dislib_0010-6339705-05_200509-233352
#unbuffer python project.py t/test --load t3ds-shapes-vae-b16-dislib_0010-6339705-08_200509-233335
#unbuffer python project.py t/test --load t3ds-shapes-wae-dislib_0040-6457811-10_200521-192058
#unbuffer python project.py t/test --load t3ds-shapes-wae-conv_0040-6457811-11_200521-192112

#unbuffer python project.py t/test --load tmpi-shapes-ae-toy-dislib_0029-6357652-03_200517-020655
#unbuffer python project.py t/test --load tmpi-shapes-vae-toy-b1-dislib_0029-6357652-04_200517-020750
#unbuffer python project.py t/test --load tmpi-shapes-vae-toy-b2-dislib_0029-6357652-02_200517-020148
#unbuffer python project.py t/test --load tmpi-shapes-wae-toy-dislib_0040-6457811-05_200521-183531
#unbuffer python project.py t/test --load tmpi-shapes-wae-toy-conv_0040-6457811-04_200521-182820

#unbuffer python project.py t/test --load tmpi-shapes-ae-real-dislib_0028-6357651-02_200517-013348
#unbuffer python project.py t/test --load tmpi-shapes-vae-real-b1-dislib_0028-6357651-03_200517-013344
#unbuffer python project.py t/test --load tmpi-shapes-vae-real-b2-dislib_0028-6357651-04_200517-013349
#unbuffer python project.py t/test --load tmpi-shapes-wae-real-dislib_0040-6457811-03_200521-182624
#unbuffer python project.py t/test --load tmpi-shapes-wae-real-conv_0040-6457811-02_200521-181826

### 50

#unbuffer python project.py a/ladder4 t/3ds-shapes m/vae --info.extra lddrev4
#unbuffer python project.py a/ladder6 t/3ds-shapes m/vae --info.extra lddrev6
#unbuffer python project.py a/ladder12 t/3ds-shapes m/vae --info.extra lddrev12

#unbuffer python project.py a/ladder4 t/mpi-shapes m/vae --dataset.category toy --info.extra toy-lddrev4
#unbuffer python project.py a/ladder6 t/mpi-shapes m/vae --dataset.category toy --info.extra toy-lddrev6
#unbuffer python project.py a/ladder12 t/mpi-shapes m/vae --dataset.category toy --info.extra toy-lddrev12

#unbuffer python project.py a/ladder4 t/mpi-shapes m/vae --dataset.category real --info.extra real-lddrev4
#unbuffer python project.py a/ladder6 t/mpi-shapes m/vae --dataset.category real --info.extra real-lddrev6
#unbuffer python project.py a/ladder12 t/mpi-shapes m/vae --dataset.category real --info.extra real-lddrev12

### 51

#unbuffer python project.py a/ladder4 t/3ds-shapes m/ae --info.extra lddrev4
#unbuffer python project.py a/ladder6 t/3ds-shapes m/ae --info.extra lddrev6
#unbuffer python project.py a/ladder12 t/3ds-shapes m/ae --info.extra lddrev12

#unbuffer python project.py a/ladder4 t/mpi-shapes m/ae --dataset.category toy --info.extra toy-lddrev4
#unbuffer python project.py a/ladder6 t/mpi-shapes m/ae --dataset.category toy --info.extra toy-lddrev6
#unbuffer python project.py a/ladder12 t/mpi-shapes m/ae --dataset.category toy --info.extra toy-lddrev12

#unbuffer python project.py a/ladder4 t/mpi-shapes m/ae --dataset.category real --info.extra real-lddrev4
#unbuffer python project.py a/ladder6 t/mpi-shapes m/ae --dataset.category real --info.extra real-lddrev6
#unbuffer python project.py a/ladder12 t/mpi-shapes m/ae --dataset.category real --info.extra real-lddrev12

### 52

#unbuffer python project.py --resume celeba-vae-b4-conv_0031-6362398-05_200517-170611

### 53-54

#unbuffer python project.py --resume celeba-wae-conv_0031-6362398-03_200517-170613
#unbuffer python project.py --resume celeba-vae-b2-conv-s2_0031-6362398-08_200517-170614

### 55

#unbuffer python project.py a/lconv celeba m/wae

### 56

#unbuffer python project.py a/d/branch4 a/e/conv mpi3d m/ae --dataset.category toy --info.extra toy-4b3
#unbuffer python project.py a/d/branch6 a/e/conv mpi3d m/ae --dataset.category toy --info.extra toy-6b2

#unbuffer python project.py a/d/branch4 a/e/conv mpi3d m/ae --dataset.category real --info.extra real-4b3
#unbuffer python project.py a/d/branch6 a/e/conv mpi3d m/ae --dataset.category real --info.extra real-6b2

### 57

#unbuffer python project.py --resume mpi3d-vae-lddrev6_0042-6464006-12_200522-152917

### 58

#unbuffer python project.py a/d/branch4 a/e/conv mpi3d m/ae --dataset.category toy --info.extra toy-4b3

### 59-60

#unbuffer python project.py final --resume 3ds-ae-conv_0002-6337051-00_200508-232722
#unbuffer python project.py final --resume 3ds-ae-b1-conv_0002-6337051-01_200508-232718
#unbuffer python project.py final --resume 3ds-vae-b1-conv_0002-6337051-03_200508-232715
#unbuffer python project.py final --resume 3ds-vae-b2-conv_0002-6337051-04_200508-232711
#unbuffer python project.py final --resume 3ds-vae-b4-conv_0002-6337051-05_200508-232713
#unbuffer python project.py final --resume 3ds-vae-b8-conv_0002-6337051-06_200508-232748
#unbuffer python project.py final --resume 3ds-vae-b16-conv_0002-6337051-07_200508-232723
#unbuffer python project.py final --resume 3ds-vae-b32-conv_0002-6337051-08_200508-232717
#unbuffer python project.py final --resume 3ds-wae-conv_0002-6337051-02_200508-232718
#unbuffer python project.py final --resume 3ds-ae-12b1-conv_0005-6337809-01_200509-120419
#unbuffer python project.py final --resume 3ds-ae-6b2-conv_0034-6373616-01_200518-163704
#unbuffer python project.py final --resume 3ds-ae-4b3-conv_0034-6373616-00_200518-163709
#unbuffer python project.py final --resume 3ds-ae-12b1-12h1k32v32_0001-6337050-04_200508-232612
#unbuffer python project.py final --resume 3ds-ae-12b1-6h1k32v32_0001-6337050-08_200508-232652
#unbuffer python project.py final --resume 3ds-ae-12b1-4h1k32v32_0001-6337050-07_200508-232614
#unbuffer python project.py final --resume 3ds-vae-lddrev12_0042-6464006-07_200522-152910
#unbuffer python project.py final --resume 3ds-ae-lddrev12_0042-6464006-04_200522-152948
#unbuffer python project.py final --resume 3ds-vae-lddrev6_0042-6464006-06_200522-152917
#unbuffer python project.py final --resume 3ds-ae-lddrev6_0042-6464006-03_200522-152912
#unbuffer python project.py final --resume 3ds-vae-lddrev4_0042-6464006-05_200522-152911
#unbuffer python project.py final --resume 3ds-ae-lddrev4_0042-6464006-02_200522-152915
#unbuffer python project.py final --resume 3ds-ae-dislib_0003-6337807-00_200509-120112
#unbuffer python project.py final --resume 3ds-ae-b1-dislib_0003-6337807-01_200509-120113
#unbuffer python project.py final --resume 3ds-vae-b1-dislib_0003-6337807-03_200509-120115
#unbuffer python project.py final --resume 3ds-vae-b2-dislib_0003-6337807-04_200509-120115
#unbuffer python project.py final --resume 3ds-vae-b4-dislib_0003-6337807-05_200509-120125
#unbuffer python project.py final --resume 3ds-vae-b8-dislib_0003-6337807-06_200509-120109
#unbuffer python project.py final --resume 3ds-vae-b16-dislib_0003-6337807-07_200509-120113
#unbuffer python project.py final --resume 3ds-vae-b32-dislib_0003-6337807-08_200509-120119
#unbuffer python project.py final --resume 3ds-wae-dislib_0003-6337807-02_200509-120136

### 61

#unbuffer python project.py final --resume mpi3d-ae-conv_0011-6341579-00_200511-035009
#unbuffer python project.py final --resume mpi3d-ae-b1-conv_0011-6341579-01_200511-035004
#unbuffer python project.py final --resume mpi3d-vae-b1-conv_0011-6341579-03_200511-035007
#unbuffer python project.py final --resume mpi3d-vae-b2-conv_0011-6341579-04_200511-035008
#unbuffer python project.py final --resume mpi3d-vae-b4-conv_0011-6341579-05_200511-035016
#unbuffer python project.py final --resume mpi3d-vae-b8-conv_0011-6341579-06_200511-035007
#unbuffer python project.py final --resume mpi3d-vae-b16-conv_0011-6341579-07_200511-035003
#unbuffer python project.py final --resume mpi3d-wae-conv_0011-6341579-02_200511-035010
#unbuffer python project.py final --resume mpi3d-ae-12b1-conv_0011-6341579-09_200511-035023
#unbuffer python project.py final --resume mpi3d-ae-toy-6b2_0056-6468034-01_200525-033418
#unbuffer python project.py final --resume mpi3d-ae-12b1-12h1k32v32_0013-6343740-04_200512-014614
#unbuffer python project.py final --resume mpi3d-ae-12b1-6h1k32v32_0013-6343740-08_200512-014603
#unbuffer python project.py final --resume mpi3d-ae-12b1-4h1k32v32_0013-6343740-07_200512-014605
#unbuffer python project.py final --resume mpi3d-vae-lddrev12_0042-6464006-13_200522-152922
#unbuffer python project.py final --resume mpi3d-ae-lddrev12_0042-6464006-10_200522-152920
#unbuffer python project.py final --resume mpi3d-ae-lddrev6_0042-6464006-09_200522-152920
#unbuffer python project.py final --resume mpi3d-vae-lddrev4_0042-6464006-11_200522-152927
#unbuffer python project.py final --resume mpi3d-ae-lddrev4_0042-6464006-08_200522-152926

### 62

#unbuffer python project.py final --resume mpi3d-ae-conv_0012-6341580-00_200511-035101
#unbuffer python project.py final --resume mpi3d-ae-b1-conv_0012-6341580-01_200511-035039
#unbuffer python project.py final --resume mpi3d-vae-b1-conv_0012-6341580-03_200511-035054
#unbuffer python project.py final --resume mpi3d-vae-b2-conv_0012-6341580-04_200511-035041
#unbuffer python project.py final --resume mpi3d-vae-b4-conv_0012-6341580-05_200511-035040
#unbuffer python project.py final --resume mpi3d-vae-b8-conv_0012-6341580-06_200511-035042
#unbuffer python project.py final --resume mpi3d-vae-b16-conv_0012-6341580-07_200511-035036
#unbuffer python project.py final --resume mpi3d-wae-conv_0012-6341580-02_200511-035101
#unbuffer python project.py final --resume mpi3d-ae-12b1-conv_0012-6341580-09_200511-035033
#unbuffer python project.py final --resume mpi3d-ae-real-6b2_0056-6468034-03_200525-033420
#unbuffer python project.py final --resume mpi3d-ae-real-4b3_0056-6468034-02_200525-033422
#unbuffer python project.py final --resume mpi3d-ae-12b1-12h1k32v32_0015-6346974-04_200513-020758
#unbuffer python project.py final --resume mpi3d-ae-12b1-6h1k32v32_0015-6346974-08_200513-020756
#unbuffer python project.py final --resume mpi3d-ae-12b1-4h1k32v32_0015-6346974-07_200513-020753
#unbuffer python project.py final --resume mpi3d-vae-real-lddrev12_0048-6464516-02_200522-212011
#unbuffer python project.py final --resume mpi3d-vae-real-lddrev6_0048-6464516-01_200522-212003
#unbuffer python project.py final --resume mpi3d-vae-real-lddrev4_0048-6464516-00_200522-212001

### 63

#unbuffer python project.py t/upd --load t3ds-shapes-vae-lddrev4_0050-6465005-00_200523-155658
#unbuffer python project.py t/upd --load t3ds-shapes-vae-lddrev6_0050-6465005-01_200523-155659
#unbuffer python project.py t/upd --load t3ds-shapes-vae-lddrev12_0050-6465005-02_200523-155700
#unbuffer python project.py t/upd --load tmpi-shapes-vae-real-lddrev12_0050-6465005-08_200523-155703
#unbuffer python project.py t/upd --load tmpi-shapes-vae-toy-lddrev6_0050-6465005-04_200523-155705
#unbuffer python project.py t/upd --load tmpi-shapes-vae-toy-lddrev12_0050-6465005-05_200523-155707
#unbuffer python project.py t/upd --load tmpi-shapes-vae-real-lddrev4_0050-6465005-06_200523-155708
#unbuffer python project.py t/upd --load tmpi-shapes-vae-real-lddrev6_0050-6465005-07_200523-155709
#unbuffer python project.py t/upd --load tmpi-shapes-vae-toy-lddrev4_0050-6465005-03_200523-155710

#unbuffer python project.py t/upd --load t3ds-shapes-ae-lddrev4_0051-6465006-00_200523-155726
#unbuffer python project.py t/upd --load t3ds-shapes-ae-lddrev12_0051-6465006-02_200523-155728
#unbuffer python project.py t/upd --load t3ds-shapes-ae-lddrev6_0051-6465006-01_200523-155730
#unbuffer python project.py t/upd --load tmpi-shapes-ae-toy-lddrev4_0051-6465006-03_200523-155735
#unbuffer python project.py t/upd --load tmpi-shapes-ae-real-lddrev12_0051-6465006-08_200523-155735
#unbuffer python project.py t/upd --load tmpi-shapes-ae-real-lddrev4_0051-6465006-06_200523-155738
#unbuffer python project.py t/upd --load tmpi-shapes-ae-real-lddrev6_0051-6465006-07_200523-155739
#unbuffer python project.py t/upd --load tmpi-shapes-ae-toy-lddrev12_0051-6465006-05_200523-155740
#unbuffer python project.py t/upd --load tmpi-shapes-ae-toy-lddrev6_0051-6465006-04_200523-155742

### 64

#unbuffer python project.py t/test --load t3ds-shapes-ae-12b1-12h-conv_0044-6464095-00_200522-161032
#unbuffer python project.py t/test --load t3ds-shapes-ae-12b1-6h-conv_0044-6464095-01_200522-161027
#unbuffer python project.py t/test --load t3ds-shapes-ae-12b1-4h-conv_0044-6464095-02_200522-161025

#unbuffer python project.py t/test --load tmpi-shapes-ae-toy-12b1-12h-conv_0044-6464095-03_200522-161036
#unbuffer python project.py t/test --load tmpi-shapes-ae-toy-12b1-4h-conv_0044-6464095-04_200522-161034

#unbuffer python project.py t/test --load tmpi-shapes-ae-real-12b1-6h-conv_0044-6464095-06_200522-161033
#unbuffer python project.py t/test --load tmpi-shapes-ae-real-12b1-4h-conv_0044-6464095-07_200522-161035

### 65

#unbuffer python project.py final --resume celeba-vae-b4-conv_0031-6362398-05_200517-170611
#unbuffer python project.py final --resume celeba-ae-12b1-conv_0031-6362398-00_200517-170612
#unbuffer python project.py final --resume celeba-vae-b1-conv_0031-6362398-04_200517-170613
#unbuffer python project.py final --resume celeba-vae-b2-conv-s2_0031-6362398-08_200517-170614
#unbuffer python project.py final --resume celeba-ae-12b1-conv-s2_0031-6362398-07_200517-170615
#unbuffer python project.py final --resume celeba-vae-b2-conv_0031-6362398-01_200517-170616
#unbuffer python project.py final --resume celeba-ae-conv_0031-6362398-02_200517-170621
#unbuffer python project.py final --resume celeba-vae-b16-conv_0031-6362398-06_200517-170622

### 66

#unbuffer python project.py t/test --load t3ds-shapes-vae-lddrev12_0063-6470278-02_200525-212130
#unbuffer python project.py t/test --load t3ds-shapes-ae-lddrev12_0063-6470278-10_200525-212135
#unbuffer python project.py t/test --load t3ds-shapes-vae-lddrev6_0063-6470278-01_200525-212141
#unbuffer python project.py t/test --load t3ds-shapes-ae-lddrev6_0063-6470278-11_200525-212130
#unbuffer python project.py t/test --load t3ds-shapes-vae-lddrev4_0063-6470278-00_200525-212135
#unbuffer python project.py t/test --load t3ds-shapes-ae-lddrev4_0063-6470278-09_200525-212134

#unbuffer python project.py t/test --load tmpi-shapes-vae-toy-lddrev12_0063-6470278-05_200525-212135
#unbuffer python project.py t/test --load tmpi-shapes-ae-toy-lddrev12_0063-6470278-16_200525-212133
#unbuffer python project.py t/test --load tmpi-shapes-vae-toy-lddrev6_0063-6470278-04_200525-212131
#unbuffer python project.py t/test --load tmpi-shapes-ae-toy-lddrev6_0063-6470278-17_200525-212134
#unbuffer python project.py t/test --load tmpi-shapes-vae-toy-lddrev4_0063-6470278-08_200525-212143
#unbuffer python project.py t/test --load tmpi-shapes-ae-toy-lddrev4_0063-6470278-12_200525-212133

#unbuffer python project.py t/test --load tmpi-shapes-vae-real-lddrev12_0063-6470278-03_200525-212143
#unbuffer python project.py t/test --load tmpi-shapes-ae-real-lddrev12_0063-6470278-13_200525-212137
#unbuffer python project.py t/test --load tmpi-shapes-vae-real-lddrev6_0063-6470278-07_200525-212158
#unbuffer python project.py t/test --load tmpi-shapes-ae-real-lddrev6_0063-6470278-15_200525-212149
#unbuffer python project.py t/test --load tmpi-shapes-vae-real-lddrev4_0063-6470278-06_200525-212137
#unbuffer python project.py t/test --load tmpi-shapes-ae-real-lddrev4_0063-6470278-14_200525-212145

### 67

#unbuffer python project.py t/upd --seed 2 --load tmpi-shapes-ae-real-12b1-12h-conv_0039-6425005-06_200521-165855
#unbuffer python project.py a/d/branch12 a/e/attn6 t/mpi-shapes m/ae --seed 2 --dataset.category toy --info.extra toy-12b1-6h-conv
#unbuffer python project.py t/test --seed 2 --load t3ds-shapes-ae-12b1-12h-conv_0044-6464095-00_200522-161032

### 68

#unbuffer python project.py a/d/branch4 a/e/conv t/mpi-shapes m/ae --dataset.category toy --info.extra toy-4b3-conv-s2 --seed 2
#unbuffer python project.py a/ladder6 t/mpi-shapes m/vae --dataset.category toy --info.extra toy-lddrev6-s2 --seed 2

#unbuffer python project.py a/ladder12 t/mpi-shapes m/ae --dataset.category real --info.extra toy-lddrev12-s2 --seed 2
#unbuffer python project.py a/ladder6 t/mpi-shapes m/ae --dataset.category real --info.extra toy-lddrev6-s2 --seed 2
#unbuffer python project.py a/ladder4 t/mpi-shapes m/ae --dataset.category real --info.extra toy-lddrev4-s2 --seed 2

### 69

#unbuffer python project.py a/ladder16 celeba m/vae --info.extra lddrev12-s2 --seed 2
#unbuffer python project.py a/ladder16 celeba m/vae --info.extra lddrev12-s3 --seed 3

### 70

#unbuffer python project.py final --resume tmpi-shapes-ae-real-12b1-conv_0024-6352333-00_200516-045012
#unbuffer python project.py final --resume t3ds-shapes-ae-6b2-conv_0040-6457811-09_200521-192043
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-conv_0046-6464099-00_200522-161235
#unbuffer python project.py final --resume tmpi-shapes-ae-real-4b3-conv_0040-6457811-00_200521-181732
#unbuffer python project.py final --resume t3ds-shapes-ae-dislib_0008-6337836-00_200509-130737
#unbuffer python project.py final --resume tmpi-shapes-ae-real-dislib_0049-6464925-10_200523-124452
#unbuffer python project.py final --resume tmpi-shapes-vae-toy-b2-dislib_0049-6464925-07_200523-124449
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-12b1-4h-conv_0039-6425005-05_200521-165857
#unbuffer python project.py final --resume tmpi-shapes-vae-toy-lddrev6_0063-6470278-04_200525-212131
#unbuffer python project.py final --resume tmpi-shapes-vae-toy-b1-conv_0025-6352334-06_200516-080145
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-4b3-conv_0036-6424644-04_200521-041527
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-12b1-conv_0029-6357652-00_200517-021120
#unbuffer python project.py final --resume tmpi-shapes-vae-toy-b1-dislib_0025-6352334-04_200516-073618
#unbuffer python project.py final --resume tmpi-shapes-vae-toy-b2-dislib_0029-6357652-02_200517-020148
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-4b3-conv_0040-6457811-07_200521-190415
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-6b2-conv_0046-6464099-04_200522-161237
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-conv_0025-6352334-05_200516-080143
#unbuffer python project.py final --resume tmpi-shapes-wae-real-dislib_0040-6457811-03_200521-182624
#unbuffer python project.py final --resume t3ds-shapes-ae-conv_0008-6337836-03_200509-130726
#unbuffer python project.py final --resume t3ds-shapes-vae-lddrev6_0050-6465005-01_200523-155659
#unbuffer python project.py final --resume t3ds-shapes-vae-lddrev4_0050-6465005-00_200523-155658
#unbuffer python project.py final --resume tmpi-shapes-vae-toy-b1-conv_0046-6464099-01_200522-161238
#unbuffer python project.py final --resume tmpi-shapes-ae-real-conv_0024-6352333-05_200516-045535
#unbuffer python project.py final --resume tmpi-shapes-ae-real-12b1-conv_0028-6357651-00_200517-013342
#unbuffer python project.py final --resume t3ds-shapes-ae-lddrev4_0063-6470278-09_200525-212134
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-dislib_0029-6357652-03_200517-020655
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-12b1-4h-conv_0044-6464095-04_200522-161034
#unbuffer python project.py final --resume t3ds-shapes-ae-12b1-4h-conv_0064-6470724-02_200526-012657
#unbuffer python project.py final --resume tmpi-shapes-vae-toy-lddrev12_0050-6465005-05_200523-155707
#unbuffer python project.py final --resume t3ds-shapes-ae-12b1-12h-conv_0039-6425005-00_200521-150816
#unbuffer python project.py final --resume tmpi-shapes-wae-toy-conv_0049-6464925-09_200523-124449
#unbuffer python project.py final --resume tmpi-shapes-vae-real-lddrev12_0050-6465005-08_200523-155703
#unbuffer python project.py final --resume t3ds-shapes-ae-6b2-conv_0036-6424644-09_200521-042750
#unbuffer python project.py final --resume tmpi-shapes-ae-real-lddrev6_0063-6470278-15_200525-212149
#unbuffer python project.py final --resume t3ds-shapes-wae-conv_0036-6424644-11_200521-045803
#unbuffer python project.py final --resume tmpi-shapes-wae-toy-conv_0036-6424644-07_200521-041512
#unbuffer python project.py final --resume t3ds-shapes-ae-12b1-12h-conv_0044-6464095-00_200522-161032
#unbuffer python project.py final --resume t3ds-shapes-ae-dislib_0049-6464925-00_200523-124442
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-12b1-12h-conv_0044-6464095-03_200522-161036
#unbuffer python project.py final --resume tmpi-shapes-ae-real-conv_0028-6357651-05_200517-013845
#unbuffer python project.py final --resume tmpi-shapes-wae-real-conv_0036-6424644-03_200521-041510
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-12b1-12h-conv_0064-6470724-03_200526-012703
#unbuffer python project.py final --resume tmpi-shapes-wae-real-conv_0040-6457811-02_200521-181826
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-dislib_0025-6352334-03_200516-073329
#unbuffer python project.py final --resume tmpi-shapes-vae-real-b1-dislib_0024-6352333-04_200516-045409
#unbuffer python project.py final --resume tmpi-shapes-wae-real-dislib_0049-6464925-13_200523-124448
#unbuffer python project.py final --resume tmpi-shapes-vae-toy-b1-conv_0029-6357652-06_200517-021252
#unbuffer python project.py final --resume tmpi-shapes-vae-toy-b2-conv_0046-6464099-02_200522-161238
#unbuffer python project.py final --resume tmpi-shapes-ae-real-12b1-4h-conv_0044-6464095-07_200522-161035
#unbuffer python project.py final --resume t3ds-shapes-vae-b16-dislib_0010-6339705-08_200509-233335
#unbuffer python project.py final --resume t3ds-shapes-ae-12b1-4h-conv_0039-6425005-02_200521-150810
#unbuffer python project.py final --resume tmpi-shapes-ae-real-12b1-conv_0047-6464126-03_200522-164159
#unbuffer python project.py final --resume tmpi-shapes-vae-real-b1-dislib_0049-6464925-11_200523-124446
#unbuffer python project.py final --resume tmpi-shapes-ae-real-4b3-conv_0047-6464126-05_200522-164156
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-lddrev12_0063-6470278-16_200525-212133
#unbuffer python project.py final --resume tmpi-shapes-wae-toy-conv_0040-6457811-04_200521-182820
#unbuffer python project.py final --resume tmpi-shapes-ae-real-12b1-6h-conv_0044-6464095-06_200522-161033
#unbuffer python project.py final --resume tmpi-shapes-vae-real-lddrev6_0050-6465005-07_200523-155709
#unbuffer python project.py final --resume tmpi-shapes-ae-real-dislib_0024-6352333-03_200516-045408
#unbuffer python project.py final --resume t3ds-shapes-wae-conv_0049-6464925-04_200523-124438
#unbuffer python project.py final --resume tmpi-shapes-wae-real-dislib_0036-6424644-02_200521-041518
#unbuffer python project.py final --resume t3ds-shapes-vae-lddrev12_0063-6470278-02_200525-212130
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-12b1-conv_0046-6464099-03_200522-161244
#unbuffer python project.py final --resume t3ds-shapes-ae-12b1-6h-conv_0064-6470724-01_200526-012651
#unbuffer python project.py final --resume tmpi-shapes-vae-toy-b2-dislib_0025-6352334-02_200516-071120
#unbuffer python project.py final --resume t3ds-shapes-ae-lddrev6_0051-6465006-01_200523-155730
#unbuffer python project.py final --resume t3ds-shapes-vae-b16-conv_0045-6464097-03_200522-161128
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-dislib_0049-6464925-05_200523-124445
#unbuffer python project.py final --resume t3ds-shapes-vae-lddrev6_0063-6470278-01_200525-212141
#unbuffer python project.py final --resume t3ds-shapes-vae-lddrev12_0050-6465005-02_200523-155700
#unbuffer python project.py final --resume tmpi-shapes-vae-toy-lddrev4_0050-6465005-03_200523-155710
#unbuffer python project.py final --resume tmpi-shapes-ae-real-6b2-conv_0040-6457811-01_200521-181822
#unbuffer python project.py final --resume tmpi-shapes-ae-real-lddrev12_0063-6470278-13_200525-212137
#unbuffer python project.py final --resume t3ds-shapes-vae-b1-conv_0045-6464097-02_200522-161132
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-lddrev6_0063-6470278-17_200525-212134
#unbuffer python project.py final --resume tmpi-shapes-wae-toy-dislib_0036-6424644-06_200521-041517
#unbuffer python project.py final --resume t3ds-shapes-vae-b16-conv_0010-6339705-04_200509-233331
#unbuffer python project.py final --resume tmpi-shapes-vae-real-lddrev6_0063-6470278-07_200525-212158
#unbuffer python project.py final --resume tmpi-shapes-vae-toy-lddrev4_0063-6470278-08_200525-212143
#unbuffer python project.py final --resume t3ds-shapes-vae-b1-dislib_0008-6337836-01_200509-130731
#unbuffer python project.py final --resume tmpi-shapes-ae-real-12b1-4h-conv_0064-6470724-06_200526-012742
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-lddrev12_0051-6465006-05_200523-155740
#unbuffer python project.py final --resume t3ds-shapes-ae-6b2-conv_0045-6464097-04_200522-161130
#unbuffer python project.py final --resume tmpi-shapes-ae-real-dislib_0028-6357651-02_200517-013348
#unbuffer python project.py final --resume tmpi-shapes-vae-toy-b2-conv_0025-6352334-01_200516-070414
#unbuffer python project.py final --resume tmpi-shapes-ae-real-lddrev6_0051-6465006-07_200523-155739
#unbuffer python project.py final --resume tmpi-shapes-vae-toy-b1-dislib_0029-6357652-04_200517-020750
#unbuffer python project.py final --resume tmpi-shapes-ae-real-conv_0047-6464126-00_200522-164208
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-6b2-conv_0036-6424644-05_200521-041517
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-4b3-conv_0046-6464099-05_200522-161240
#unbuffer python project.py final --resume tmpi-shapes-wae-toy-dislib_0049-6464925-08_200523-124449
#unbuffer python project.py final --resume tmpi-shapes-vae-toy-lddrev6_0050-6465005-04_200523-155705
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-lddrev4_0051-6465006-03_200523-155735
#unbuffer python project.py final --resume tmpi-shapes-vae-toy-b2-conv_0029-6357652-01_200517-015851
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-lddrev6_0051-6465006-04_200523-155742
#unbuffer python project.py final --resume t3ds-shapes-wae-dislib_0040-6457811-10_200521-192058
#unbuffer python project.py final --resume tmpi-shapes-vae-real-b1-dislib_0028-6357651-03_200517-013344
#unbuffer python project.py final --resume t3ds-shapes-ae-12b1-4h-conv_0044-6464095-02_200522-161025
#unbuffer python project.py final --resume t3ds-shapes-ae-4b3-conv_0036-6424644-08_200521-042709
#unbuffer python project.py final --resume tmpi-shapes-vae-real-lddrev4_0050-6465005-06_200523-155708
#unbuffer python project.py final --resume t3ds-shapes-vae-b16-dislib_0049-6464925-02_200523-124440
#unbuffer python project.py final --resume tmpi-shapes-wae-toy-dislib_0040-6457811-05_200521-183531
#unbuffer python project.py final --resume tmpi-shapes-ae-real-4b3-conv_0036-6424644-00_200521-041456
#unbuffer python project.py final --resume tmpi-shapes-ae-real-12b1-6h-conv_0039-6425005-07_200521-181623
#unbuffer python project.py final --resume t3ds-shapes-wae-dislib_0049-6464925-03_200523-124440
#unbuffer python project.py final --resume tmpi-shapes-ae-real-12b1-6h-conv_0064-6470724-05_200526-012737
#unbuffer python project.py final --resume t3ds-shapes-vae-b1-conv_0010-6339705-06_200509-233330
#unbuffer python project.py final --resume t3ds-shapes-wae-conv_0040-6457811-11_200521-192112
#unbuffer python project.py final --resume tmpi-shapes-vae-real-b1-conv_0028-6357651-06_200517-014147
#unbuffer python project.py final --resume tmpi-shapes-vae-real-b1-conv_0047-6464126-01_200522-164204
#unbuffer python project.py final --resume tmpi-shapes-vae-real-b2-dislib_0049-6464925-12_200523-124446
#unbuffer python project.py final --resume t3ds-shapes-vae-b1-conv_0008-6337836-04_200509-130733
#unbuffer python project.py final --resume tmpi-shapes-ae-real-6b2-conv_0047-6464126-04_200522-164201
#unbuffer python project.py final --resume t3ds-shapes-ae-lddrev4_0051-6465006-00_200523-155726
#unbuffer python project.py final --resume tmpi-shapes-vae-real-b1-conv_0024-6352333-06_200516-052106
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-12b1-12h-conv_0039-6425005-03_200521-150814
#unbuffer python project.py final --resume t3ds-shapes-vae-b1-dislib_0049-6464925-01_200523-124437
#unbuffer python project.py final --resume tmpi-shapes-vae-real-lddrev4_0063-6470278-06_200525-212137
#unbuffer python project.py final --resume tmpi-shapes-vae-real-b2-conv_0047-6464126-02_200522-164157
#unbuffer python project.py final --resume tmpi-shapes-ae-real-12b1-12h-conv_0039-6425005-06_200521-165855
#unbuffer python project.py final --resume t3ds-shapes-ae-12b1-conv_0010-6339705-00_200509-233443
#unbuffer python project.py final --resume t3ds-shapes-vae-b16-conv_0008-6337836-05_200509-130729
#unbuffer python project.py final --resume t3ds-shapes-ae-dislib_0010-6339705-07_200509-233331
#unbuffer python project.py final --resume t3ds-shapes-ae-12b1-conv_0045-6464097-00_200522-161132
#unbuffer python project.py final --resume t3ds-shapes-ae-12b1-6h-conv_0039-6425005-01_200521-150812
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-6b2-conv_0040-6457811-06_200521-185626
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-conv_0029-6357652-05_200517-020945
#unbuffer python project.py final --resume tmpi-shapes-vae-toy-b1-dislib_0049-6464925-06_200523-124445
#unbuffer python project.py final --resume tmpi-shapes-vae-real-b2-dislib_0028-6357651-04_200517-013349
#unbuffer python project.py final --resume t3ds-shapes-ae-12b1-6h-conv_0044-6464095-01_200522-161027
#unbuffer python project.py final --resume tmpi-shapes-vae-real-lddrev12_0063-6470278-03_200525-212143
#unbuffer python project.py final --resume tmpi-shapes-ae-real-lddrev4_0063-6470278-14_200525-212145
#unbuffer python project.py final --resume t3ds-shapes-ae-lddrev12_0051-6465006-02_200523-155728
#unbuffer python project.py final --resume tmpi-shapes-vae-real-b2-conv_0028-6357651-01_200517-013344
#unbuffer python project.py final --resume t3ds-shapes-ae-conv_0010-6339705-03_200509-233342
#unbuffer python project.py final --resume tmpi-shapes-ae-real-6b2-conv_0036-6424644-01_200521-041505
#unbuffer python project.py final --resume t3ds-shapes-vae-b1-dislib_0010-6339705-05_200509-233352
#unbuffer python project.py final --resume t3ds-shapes-vae-b16-dislib_0008-6337836-02_200509-130744
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-12b1-4h-conv_0064-6470724-04_200526-012701
#unbuffer python project.py final --resume t3ds-shapes-ae-lddrev6_0063-6470278-11_200525-212130
#unbuffer python project.py final --resume tmpi-shapes-wae-real-conv_0049-6464925-14_200523-124450
#unbuffer python project.py final --resume tmpi-shapes-ae-real-lddrev4_0051-6465006-06_200523-155738
#unbuffer python project.py final --resume tmpi-shapes-vae-real-b2-dislib_0024-6352333-02_200516-045414
#unbuffer python project.py final --resume t3ds-shapes-ae-conv_0045-6464097-01_200522-161131
#unbuffer python project.py final --resume t3ds-shapes-ae-12b1-conv_0008-6337836-10_200509-130720
#unbuffer python project.py final --resume tmpi-shapes-ae-real-12b1-4h-conv_0039-6425005-08_200521-181701
#unbuffer python project.py final --resume tmpi-shapes-vae-toy-lddrev12_0063-6470278-05_200525-212135
#unbuffer python project.py final --resume t3ds-shapes-ae-4b3-conv_0045-6464097-05_200522-161133
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-12b1-conv_0025-6352334-00_200516-065917
#unbuffer python project.py final --resume t3ds-shapes-ae-4b3-conv_0040-6457811-08_200521-190411
#unbuffer python project.py final --resume t3ds-shapes-ae-lddrev12_0063-6470278-10_200525-212135
#unbuffer python project.py final --resume tmpi-shapes-ae-toy-lddrev4_0063-6470278-12_200525-212133
#unbuffer python project.py final --resume t3ds-shapes-wae-dislib_0036-6424644-10_200521-043552
#unbuffer python project.py final --resume tmpi-shapes-vae-real-b2-conv_0024-6352333-01_200516-045110
#unbuffer python project.py final --resume t3ds-shapes-vae-lddrev4_0063-6470278-00_200525-212135
#unbuffer python project.py final --resume tmpi-shapes-ae-real-lddrev12_0051-6465006-08_200523-155735

### 71

#unbuffer python project.py a/d/branch4 a/e/conv mpi3d m/ae --dataset.category toy --info.extra toy-4b3-conv
#unbuffer python project.py a/ladder6 mpi3d m/vae --dataset.category toy --info.extra toy-lddrev6
#unbuffer python project.py a/ladder12 mpi3d m/ae --dataset.category real --info.extra real-lddrev12
#unbuffer python project.py a/ladder6 mpi3d m/ae --dataset.category real --info.extra real-lddrev6
#unbuffer python project.py a/ladder4 mpi3d m/ae --dataset.category real --info.extra real-lddrev4

#unbuffer python project.py a/d/branch4 a/e/conv mpi3d m/ae --dataset.category toy --info.extra toy-4b3-conv-s2 --seed 2
#unbuffer python project.py a/ladder6 mpi3d m/vae --dataset.category toy --info.extra toy-lddrev6-s2 --seed 2
#unbuffer python project.py a/ladder12 mpi3d m/ae --dataset.category real --info.extra real-lddrev12-s2 --seed 2
#unbuffer python project.py a/ladder6 mpi3d m/ae --dataset.category real --info.extra real-lddrev6-s2 --seed 2
#unbuffer python project.py a/ladder4 mpi3d m/ae --dataset.category real --info.extra real-lddrev4-s2 --seed 2

### 72

#unbuffer python project.py final --resume mpi3d-ae-toy-4b3-conv_0071-6472326-00_200526-191939

###




####


#unbuffer python project.py t/upd --load ""

###

#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1-instance --model.norm instance



###




#unbuffer python project.py a/e/attn12 a/d/deconv m/ae 3dshapes --model.keys_per_head 4 --model.weight_keys 0

#unbuffer python project.py --resume



#unbuffer python project.py a/d/branch12 a/e/conv m/ae 3dshapes --info.extra 12b1

#unbuffer python project.py a/d/branch6 a/e/conv m/ae 3dshapes --info.extra 6b2

#unbuffer python project.py a/d/branch4 a/e/conv m/ae 3dshapes --info.extra 4b3

#unbuffer python project.py a/d/root4 a/e/conv m/ae 3dshapes --info.extra 4b2r4
#unbuffer python project.py a/d/root8 a/e/conv m/ae 3dshapes --info.extra 4b1r8










