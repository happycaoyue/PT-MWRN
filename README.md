# Progressive Training of Multi-level Wavelet Residual Networks for Image Denoising

## Acknowledgement

Thank the Professor Wangmeng Zuo for his guidance and help in this work.

## Abstract
Recent years have witnessed the great success of deep convolutional neural networks (CNNs) in image denoising. Albeit deeper network and larger model capacity generally benefit performance, it remains a challenging practical issue to train a very deep image denoising network. Using multilevel wavelet-CNN (MWCNN) as an example, we empirically find that the denoising performance cannot be significantly improved by either increasing wavelet decomposition levels or increasing convolution layers within each level. To cope with this issue, this paper presents a multi-level wavelet residual network (MWRN) architecture as well as a progressive training (PTMWRN) scheme to improve image denoising performance. In contrast to MWCNN, our MWRN introduces several residual blocks after each level of discrete wavelet transform (DWT) and before inverse discrete wavelet transform (IDWT). For easing
the training difficulty, scale-specific loss is applied to each level of MWRN by requiring the intermediate output to approximate the corresponding wavelet subbands of ground-truth clean image. To ensure the effectiveness of scale-specific loss, we also take the wavelet subbands of noisy image as the input to each scale of the encoder. Furthermore, progressive training scheme is adopted for better learning of MWRN by beigining with training the lowest level of MWRN and progressively training the upper levels to bring more fine details to denoising results. Experiments on both synthetic and real-world noisy images show that our PT-MWRN performs favorably against the state-of-the-art denoising methods in terms both quantitative metrics and visual quality.

## Network Architecture(MWCNN and MWRN)

<p align="center">
    <img src="figure/1.png" width="100%">
    <br />    <small>  </small>
</p>

## Progressive Training

<p align="center">
    <img src="figure/2.png" width="100%">
    <br />    <small>  </small>
</p>

## Image denoising for Gaussian Noise

### Results on Gray-scale Image Denoising

<p align="center">
    <img src="figure/3.png" width="100%">
    <br />    <small>  </small>
</p>

### Results on Color Image Denoising (MWCNN and PT-MWRN)

<p align="center">
    <img src="figure/4.png" width="100%">
    <br />    <small>  </small>
</p>

## Image denoising for Real-world Noise


### Results on DND dataset
 
<p align="center">
    <img src="figure/5.png" width="50%">
    <br />    <small>  </small>
</p>

### Results on SIDD dataset 
 
<p align="center">
    <img src="figure/6.png" width="50%">
    <br />    <small>  </small>
</p>

## Test models

Download the pre-trained model with the following url and put it into ./models
- [BaiduNetDisk](https://pan.baidu.com/s/1xV0NfzOD2IBQOeSbREkIqQ) password：cnmu
- [GoogleDrive](https://drive.google.com/drive/folders/1GX_NQfG1-QHdfgmV8Axl1ZjlDsHUEAUV?usp=sharing)

### Image denoising
'Demo_Image_Denoising.m' is the demo of MWCNN for image denoising.


## Requirements and Dependencies
- MATLAB R2017a
- [Cuda](https://developer.nvidia.com/cuda-toolkit-archive)-8.0 & [cuDNN](https://developer.nvidia.com/cudnn) v-5.1
- [MatConvNet](http://www.vlfeat.org/matconvnet/)

## Results

Download the denoised image with the following url
- [BaiduNetDisk](https://pan.baidu.com/s/1xV0NfzOD2IBQOeSbREkIqQ) password：cnmu
- [GoogleDrive](https://drive.google.com/drive/folders/1GX_NQfG1-QHdfgmV8Axl1ZjlDsHUEAUV?usp=sharing)


## Contact
Please send email to cscaoyue@gmail.com or cscaoyue@hit.edu.com

## Others

We also will release a PyTorch version of MWRN for Gaussian Noise and Real-world Noise in the future.

## Citation

@article{cao2020progressive,

  title={Progressive Training of Multi-level Wavelet Residual Networks for Image Denoising},
  
  author={Yali Peng, Yue Cao, Shigang Liu, Jian Yang, and Wangmeng Zuo},
  
  journal={arXiv preprint},
  
  year={2020}}

## References

@InProceedings{Liu_2018_CVPR_Workshops,
author = {Liu, Pengju and Zhang, Hongzhi and Zhang, Kai and Lin, Liang and Zuo, Wangmeng},
title = {Multi-Level Wavelet-CNN for Image Restoration},
booktitle = {The IEEE Conference on Computer Vision and Pattern Recognition (CVPR) Workshops},
month = {June},
year = {2018}
}

- [MWCNN](https://github.com/lpj0/MWCNN)

@article{Liu2019MWCNN,
title={Multi-Level Wavelet Convolutional Neural Networks},
author={Liu, Pengju and Zhang, Hongzhi and Lian Wei and Zuo, Wangmeng},
journal={IEEE Access},
volume={7},
pages={74973-74985},
year={2019},
publisher={IEEE}
}

- [MWCNN_Pytorch](https://github.com/lpj-github-io/MWCNNv2)

## Acknowledgements

This code is built on - [MWCNN_MatConvNet](https://github.com/lpj0/MWCNN). We thank the authors for sharing their codes.
