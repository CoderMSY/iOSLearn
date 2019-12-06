//
//  ATBaseLogicDaoImpl.m
//  XCData
//
//  Created by SimonMiao on 2019/6/25.
//  Copyright © 2019 avatar. All rights reserved.
//

#import "ATBaseLogicDaoImpl.h"

static dispatch_queue_t ATDao_cache_writing_queue() {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_queue_attr_t attr = DISPATCH_QUEUE_SERIAL;
        if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_8_0) {
            attr = dispatch_queue_attr_make_with_qos_class(attr, QOS_CLASS_BACKGROUND, 0);
        }
        queue = dispatch_queue_create("com.avatar.dao.caching", attr);
    });
    
    return queue;
}

@implementation ATBaseLogicDaoImpl

- (instancetype)init
{
    self = [super init];
    if (self) {
        //
    }
    return self;
}

- (dispatch_queue_t)getWritingQueue {
    return ATDao_cache_writing_queue();
}

- (NSString *)getCacheBasePath {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
//    ATLog(@"%@", cachePath);
    
    return cachePath;
}

- (void)createDirectoryAtPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES
                                                   attributes:nil error:&error];
        if (error) {
            ATLog(@"create cache directory failed, error = %@", error);
        }
//        ATLog(@"create tempPath:%@", path);
    }
    else {
//        ATLog(@"已存在");
    }
}

@end
