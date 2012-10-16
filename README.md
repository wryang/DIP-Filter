DIP-Filter
==========
1.概况 
--------------
项目：实现一个通用的高通、低通、带通和带阻滤波器函数。其中又分别实现理想、巴特沃思和指数等滤波形式。用实现的函数对图1（lena_noise.bmp）进行低通处理，图2(lena_blur.bmp)进行高通处理，处理后分别进行伪彩色增强。 
<br />
实验图象： lena_noise.bmp， lena_blur.bmp
2.设计 
--------------
- 2.1主窗口
可在matlab中直接运行mainWin.fig;	
提供图像选择方式，并设定截止频率和带宽；
	默认截止频率为10，带宽为5；
	详细代码可参见mainWin.m；
	设置好值点击确认后，调用processing函数，对图像进行处理；
	
![Main Screen](http://dl.dropbox.com/u/91146904/weibao/MainWin.png)
									图1. 主界面
- 2.2理想低通滤波
采用默认模板处理；
![ILPF](http://dl.dropbox.com/u/91146904/weibao/ILPF.png)

- 2.3 理想高通滤波
采用默认模板处理；
![IHPF](http://dl.dropbox.com/u/91146904/weibao/IHPF.png) 

- 2.4 巴特沃斯低通滤波
采用默认模板处理；
![BLF](http://dl.dropbox.com/u/91146904/weibao/BLPF.png)

- 2.5巴特沃斯高通滤波
采用默认模板处理；
![BHPF](http://dl.dropbox.com/u/91146904/weibao/BHPF.png)

- 2.6 指数低通滤波
采用默认模板处理；
![ELPF](http://dl.dropbox.com/u/91146904/weibao/ELPF.png)

- 2.7 指数高通滤波
采用默认模板处理；
![EHPF](http://dl.dropbox.com/u/91146904/weibao/EHPF.png)

- 2.8 理想带通滤波
截止频率为20，带宽为10
![IBPF](http://dl.dropbox.com/u/91146904/weibao/IBPF.png)

- 2.9 理想带阻滤波
截止频率为20，带宽为10
![IBSF](http://dl.dropbox.com/u/91146904/weibao/IBSF.png)

- 2.10 巴特沃斯带通滤波
截止频率为20，带宽为10
![BBPF](http://dl.dropbox.com/u/91146904/weibao/BBPF.png)

- 2.11 巴特沃斯带阻滤波
截止频率为20，带宽为10
![BBSF](http://dl.dropbox.com/u/91146904/weibao/BBSF.png)

- 2.12 低通处理位彩色增强
先用默认数值进行低通/高通处理
![ColorConvLPF](http://dl.dropbox.com/u/91146904/weibao/ColorConvLPF.png)

为了使得采用蓝色分量的半径为4-20，设置蓝色分量为BBPH的截止频率为12， 带宽为16；
且按照作业要求，使用图像为lena_noise.bmp;

- 2.13 高通处理伪彩色增强
按照作业要求，使用图像为lena_brue.bmp;
![ColorConvHPF](http://dl.dropbox.com/u/91146904/weibao/ColorConvHPF.png)
 
