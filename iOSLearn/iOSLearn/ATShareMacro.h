//
//  ATShareMacro.h
//  iOSLearn
//
//  Created by SimonMiao on 2018/4/8.
//  Copyright © 2018年 Avatar. All rights reserved.
//

#ifndef ATShareMacro_h
#define ATShareMacro_h

#define AT_SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#ifdef DEBUG // 处于开发阶段
#define ATLog(...) NSLog(__VA_ARGS__)
#else // 处于发布阶段
#define ATLog(...)
#endif

#endif /* ATShareMacro_h */
