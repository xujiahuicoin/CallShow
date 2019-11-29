# CallShow
来电秀

1、Bannar广告每个控制器都有， 
如果去除，在ViewDidLoad中bannerShow = false

2、插页广告：
要写在执行事件的最前边，VC 中写入：  self.doStarInterstitial()
,每间隔8s重新创建一次，也就是连续点击按钮，最少间隔8s再次弹出

3、收费项目：相册选择照片，用户有一次试用（仅限指定联系人）
之后就是VIP可用

4、所有"全部人设置" VIP专属
