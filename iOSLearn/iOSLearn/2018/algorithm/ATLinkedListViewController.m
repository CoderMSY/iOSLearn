//
//  ATLinkedListViewController.m
//  iOSLearn
//
//  Created by SimonMiao on 2019/12/5.
//  Copyright © 2019 Avatar. All rights reserved.
//

#import "ATLinkedListViewController.h"
#import "BBSingleLinkedList.h"
#import "BBLinkedMap.h"

@interface ATLinkedListViewController ()

@end

@implementation ATLinkedListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 单链表
    [self testSingleLinkedList];
    // 双链表
    [self testLinkedMap];
    
    //参考： https://www.jianshu.com/p/12fe060811f2
}

- (void)testSingleLinkedList {
    BBSingleLinkedNode *tmpNode = nil;
    BBSingleLinkedList *list = [BBSingleLinkedList new];
    for (int i = 0; i < 5; i ++) {
        BBSingleLinkedNode *node = [BBSingleLinkedNode new];
        node.key = @(i).stringValue;
        node.value = [NSString stringWithFormat:@"value%d",i];
        [list insertNode:node];
        
        if (i == 3) {
            tmpNode = node;
        }
    }
    [list readAllNode];
    NSLog(@"\r\n==========\r\n");
    [list insertNodeAtHead:[BBSingleLinkedNode nodeWithKey:@"8" value:@"value8"]];
    [list insertNodeAtHead:tmpNode];
    [list readAllNode];
    NSLog(@"\r\n==========\r\n");
    [list bringNodeToHead:tmpNode];
    [list readAllNode];
    NSLog(@"\r\n==========\r\n");
    [list insertNode:[BBSingleLinkedNode nodeWithKey:@"20" value:@"value20"] afterNodeForKey:tmpNode.key];
    [list insertNode:tmpNode afterNodeForKey:tmpNode.key];
    [list readAllNode];
    NSLog(@"\r\n==========\r\n");
    [list insertNode:[BBSingleLinkedNode nodeWithKey:@"10" value:@"value10"] beforeNodeForKey:tmpNode.key];
    [list insertNode:tmpNode beforeNodeForKey:tmpNode.key];
    [list readAllNode];
    NSLog(@"\r\n==========\r\n");
    [list insertNode:[BBSingleLinkedNode nodeWithKey:@"11" value:@"value11"] beforeNodeForKey:tmpNode.key];
    [list readAllNode];
    NSLog(@"\r\n==========\r\n");
    [list insertNode:[BBSingleLinkedNode nodeWithKey:@"12" value:@"value12"] beforeNodeForKey:tmpNode.key];
    [list readAllNode];
    NSLog(@"\r\n==========\r\n");
    [list insertNode:[BBSingleLinkedNode nodeWithKey:@"13" value:@"value13"] beforeNodeForKey:tmpNode.key];
    [list readAllNode];
    NSLog(@"\r\n==========\r\n");
    [list removeNode:tmpNode];
    [list readAllNode];
    NSLog(@"\r\n==========\r\n");
    BBSingleLinkedNode *node = [list nodeForKey:@"4"];
    [list bringNodeToHead:node];
    node = [list lastNode];
    [list readAllNode];
    NSLog(@"\r\n==========\r\n");
    [list reverse];
    [list readAllNode];
    NSInteger len = [list length];
    NSLog(@"len:%ld", len);
    NSLog(@"\r\n==========\r\n");
    
}

- (void)testLinkedMap {
    BBLinkedNode *tmpNode = nil;
    BBLinkedMap *list = [BBLinkedMap new];
    for (int i = 0; i < 5; i ++) {
        BBLinkedNode *node = [BBLinkedNode new];
        node.key = @(i).stringValue;
        node.value = [NSString stringWithFormat:@"value%d",i];
        [list insertNode:node];
        
        if (i == 3) {
            tmpNode = node;
        }
    }
    [list readAllNode];
    NSLog(@"\r\n==========\r\n");
    [list insertNodeAtHead:[BBLinkedNode nodeWithKey:@"8" value:@"value8"]];
    [list insertNodeAtHead:tmpNode];
    [list readAllNode];
    NSLog(@"\r\n==========\r\n");
    [list bringNodeToHead:tmpNode];
    [list readAllNode];
    NSLog(@"\r\n==========\r\n");
    [list insertNode:[BBLinkedNode nodeWithKey:@"20" value:@"value20"] afterNodeForKey:tmpNode.key];
    [list insertNode:tmpNode afterNodeForKey:tmpNode.key];
    [list readAllNode];
    NSLog(@"\r\n==========\r\n");
    [list insertNode:[BBLinkedNode nodeWithKey:@"10" value:@"value10"] beforeNodeForKey:tmpNode.key];
    [list insertNode:tmpNode beforeNodeForKey:tmpNode.key];
    [list readAllNode];
    NSLog(@"\r\n==========\r\n");
    [list insertNode:[BBLinkedNode nodeWithKey:@"11" value:@"value11"] beforeNodeForKey:tmpNode.key];
    [list readAllNode];
    NSLog(@"\r\n==========\r\n");
    [list insertNode:[BBLinkedNode nodeWithKey:@"12" value:@"value12"] beforeNodeForKey:tmpNode.key];
    [list readAllNode];
    NSLog(@"\r\n==========\r\n");
    [list insertNode:[BBLinkedNode nodeWithKey:@"13" value:@"value13"] beforeNodeForKey:tmpNode.key];
    [list readAllNode];
    NSLog(@"\r\n==========\r\n");
    [list removeNodeForKey:tmpNode.key];
    [list readAllNode];
    NSLog(@"\r\n==========\r\n");
    BBLinkedNode *node = [list nodeForKey:@"4"];
    [list bringNodeToHead:node];
    node = [list tailNode];
    [list readAllNode];
    NSLog(@"\r\n==========\r\n");
    NSInteger len = [list length];
    BBLinkedNode *headNode = [list headNode];
    BBLinkedNode *tailNode = [list tailNode];
    NSLog(@"\r\n==========\r\n");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
