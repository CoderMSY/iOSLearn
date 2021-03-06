//
//  ATViewRelatedDefine.h
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/2.
//  Copyright © 2019 Avatar. All rights reserved.
//

#ifndef ATViewRelatedDefine_h
#define ATViewRelatedDefine_h

static NSString *const kText_uiInfo_0 = @"事件传递";
static NSString *const kText_uiInfo_1 = @"图像显示";
static NSString *const kText_uiInfo_2 = @"性能优化";
static NSString *const kText_uiInfo_3 = @"离屏渲染";

static NSString *const kText_uiInfo_detail_1 = @"图像显示原理 \n 1.CPU:输出位图 \n 2.GPU :图层渲染，纹理合成 \n 3.把结果放到帧缓冲区(frame buffer)中 \n 4.再由视频控制器根据vsync信号在指定时间之前去提取帧缓冲区的屏幕显示内容 \n 5.显示到屏幕上 \n       \n CPU工作 \n 1.Layout: UI布局，文本计算 \n 2.Display: 绘制 \n 3.Prepare: 图片解码 \n 4.Commit：提交位图 \n       \n GPU渲染管线(OpenGL) \n 顶点着色，图元装配，光栅化，片段着色，片段处理";
static NSString *const kText_uiInfo_detail_2 = @"UI卡顿掉帧原因 \n iOS设备的硬件时钟会发出Vsync（垂直同步信号），然后App的CPU会去计算屏幕要显示的内容，之后将计算好的内容提交到GPU去渲染。随后，GPU将渲染结果提交到帧缓冲区，等到下一个VSync到来时将缓冲区的帧显示到屏幕上。也就是说，一帧的显示是由CPU和GPU共同决定的。\n 一般来说，页面滑动流畅是60fps，也就是1s有60帧更新，即每隔16.7ms就要产生一帧画面，而如果CPU和GPU加起来的处理时间超过了16.7ms，就会造成掉帧甚至卡顿。\n    \n 滑动优化方案\n CPU：把以下操作放在子线程中\n 1.对象创建、调整、销毁\n 2.预排版（布局计算、文本计算、缓存高度等等）\n 3.预渲染（文本等异步绘制，图片解码等）\n   \n GPU: \n 纹理渲染，视图混合 \n 一般遇到性能问题时，考虑以下问题：\n 是否受到CPU或者GPU的限制？\n 是否有不必要的CPU渲染？\n 是否有太多的离屏渲染操作？\n 是否有太多的图层混合操作？\n 是否有奇怪的图片格式或者尺寸？\n 是否涉及到昂贵的view或者效果？\n view的层次结构是否合理？\n     \n UI绘制原理 \n 异步绘制：\n [self.layer.delegate displayLayer: ] \n 代理负责生成对应的bitmap \n 设置该bitmap作为该layer.contents属性的值";
static NSString *const kText_uiInfo_detail_3 = @"离屏渲染 \n On-Screen Rendering:当前屏幕渲染，指的是GPU的渲染操作是在当前用于显示的屏幕缓冲区中进行 \n Off-Screen Rendering:离屏渲染，分为CPU离屏渲染和GPU离屏渲染两种形式。GPU离屏渲染指的是GPU在当前屏幕缓冲区外新开辟一个缓冲区进行渲染操作 \n 应当尽量避免的则是GPU离屏渲染 \n      \n GPU离屏渲染何时会触发呢？ \n 圆角（当和maskToBounds一起使用时）、图层蒙版、阴影，设置 \n layer.shouldRasterize ＝ YES \n   \n 为什么要避免GPU离屏渲染？\n GPU需要做额外的渲染操作。通常GPU在做渲染的时候是很快的，但是涉及到offscreen-render的时候情况就可能有些不同，因为需要额外开辟一个新的缓冲区进行渲染，然后绘制到当前屏幕的过程需要做onscreen跟offscreen上下文之间的切换，这个过程的消耗会比较昂贵，涉及到OpenGL的pipeline跟barrier，而且offscreen-render在每一帧都会涉及到，因此处理不当肯定会对性能产生一定的影响。另外由于离屏渲染会增加GPU的工作量，可能会导致CPU+GPU的处理时间超出16.7ms，导致掉帧卡顿。所以可以的话应尽量减少offscreen-render的图层";


static NSString *const kText_ocCharacter_0 = @"分类";
static NSString *const kText_ocCharacter_1 = @"扩展";
static NSString *const kText_ocCharacter_2 = @"代理（Delegate）";
static NSString *const kText_ocCharacter_3 = @"通知（NSNotification)";
static NSString *const kText_ocCharacter_4 = @"KVO (Key-value observing)";
static NSString *const kText_ocCharacter_5 = @"KVC (Key-value coding)";
static NSString *const kText_ocCharacter_6 = @"属性关键字";

#endif /* ATViewRelatedDefine_h */
