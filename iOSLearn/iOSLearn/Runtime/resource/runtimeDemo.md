- (void)function1ItemClicked {
NSLog(@"=================================================================");
        
        unsigned int count;

        //获取成员变量的数组的指针
        Ivar *ivars = class_copyIvarList([ATPerson class], &count);

        for (int i=0 ; i<count; i++) {
        Ivar ivar = ivars[i];
        //根据ivar获得其成员变量的名称
        const char *name = ivar_getName(ivar);
        //C的字符串转OC的字符串
        NSString *key = [NSString stringWithUTF8String:name];
        NSLog(@"%d == %@",i,key);
        }
        // 记得释放
        free(ivars);

        //如果你的成员私有,也可以获取到 比如_education
}
