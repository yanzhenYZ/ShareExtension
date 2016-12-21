//
//  ViewController.m
//  test
//
//  Created by yanzhen on 16/10/8.
//  Copyright © 2016年 v2tech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSUserDefaults *ud = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.v2tech.test"];
    //写入数据
    UIImage *image = [[UIImage alloc] initWithData:[ud objectForKey:@"key"]];
    _imageView.image = image;
}

- (IBAction)action:(id)sender {
    UIImage *image = [UIImage imageNamed:@"test1"];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[image]
                                                                             applicationActivities:nil];
    [self.navigationController presentViewController:activityVC animated:YES completion:nil];
    
}




@end
