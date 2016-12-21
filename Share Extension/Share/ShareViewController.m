//
//  ShareViewController.m
//  Share
//
//  Created by yanzhen on 16/9/12.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "ShareViewController.h"
#import "TestViewController.h"

static const int CONTEXT_TEXT_MAX = 140;
@interface ShareViewController ()

@end

@implementation ShareViewController

-(void)viewDidLoad{
    [super viewDidLoad];
#pragma mark - 需要做国际化设置 --- 本Target
#pragma mark - 没有文字时的--placeholder
    self.placeholder = @"This is a test string!";
#pragma mark - 下面的UI
//    self.autoCompletionViewController = [[TestViewController alloc] init];
#pragma mark - 改变布局
    for (UIView *view1 in self.view.subviews) {
        if ([view1 isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
//            NSLog(@"TTTT:%@",view1.subviews);
//            UIView *test = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 375, 40)];
//            test.backgroundColor = [UIColor redColor];
//            [view1 addSubview:test];
            for (UIView *view2 in view1.subviews) {
                if ([view2 isKindOfClass:[UINavigationBar class]]) {
                    UINavigationBar *bar = (UINavigationBar *)view2;
                    bar.tintColor = [UIColor colorWithRed:1.0 green:133/255.0 blue:25/255.0 alpha:1.0];
                }
            }
        }
    }
}

- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    
    //编辑文字时会调用
    //用来限制最多输入的内容--自行设置
    if (self.textView.text.length > CONTEXT_TEXT_MAX) {
        return NO;
    }
    return YES;
}

- (void)didSelectPost {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
#pragma mark - 获取输入内容
//    NSLog(@"TTTT:%@",self.textView.text);
    
#pragma mark - 判断分享的类型
    //只需要第一个item？？？暂未证明多个
//    NSExtensionItem *item = self.extensionContext.inputItems.firstObject;
//    NSItemProvider *provider = item.attachments.firstObject;
//    //网址类型：public.url 图片：public.image
//    NSLog(@"TTTT3:%@",provider.registeredTypeIdentifiers);
    
#pragma mark - 获取分享的具体内容
    NSExtensionItem *item = self.extensionContext.inputItems.firstObject;
    NSItemProvider *provider = item.attachments.firstObject;
    NSString *typeIdentifier = provider.registeredTypeIdentifiers.firstObject;
    if ([typeIdentifier isEqualToString:@"public.url"]) {
        [provider loadItemForTypeIdentifier:provider.registeredTypeIdentifiers.firstObject options:nil completionHandler:^(NSURL *url, NSError * _Null_unspecified error) {
            //有时候获取不到，不知道为什么 ？？？
            NSLog(@"TTTT:%@",url.absoluteString);
            NSLog(@"TTTT:%@",error.localizedDescription);
        }];
    }
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
}

#pragma mark - 在下面加上UI
- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.

    TestViewController *vc = [[TestViewController alloc] init];
    __weak ShareViewController *weakSelf = self;
    
    SLComposeSheetConfigurationItem *item1 = [[SLComposeSheetConfigurationItem alloc] init];
    item1.title = @"测试1";
    item1.value = @"Test1";
//    item1.valuePending = YES;
    item1.tapHandler = ^(){
//        [weakSelf.navigationController pushViewController:vc animated:YES];
        [weakSelf pushConfigurationViewController:vc];
    };
    
    SLComposeSheetConfigurationItem *item2 = [[SLComposeSheetConfigurationItem alloc] init];
    item2.title = @"测试2";
    item2.value = @"Test2";
    //    item1.valuePending = YES;
    item2.tapHandler = ^(){
        [weakSelf pushConfigurationViewController:vc];
    };

    
    return @[item1,item2];
}


@end
