//
//  LLAliPayViewController.m
//  LLmyApp
//
//  Created by 陈林 on 2023/8/4.
//  Copyright © 2023 ManlyCamera. All rights reserved.
//

#import "LLAliPayViewController.h"
#import <AlipaySDK/AlipaySDK.h>

@interface LLAliPayViewController ()
@property (weak, nonatomic) IBOutlet UITextField *myTextfiled;
@end

@implementation LLAliPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)test {
    
//    NSInteger ar = 5;
//    NSArray *arr = @[@"", ar, @"", @""];
//    NSArray *keys = @[@"", @"", @"", @""];
//    NSDictionary *dict = [[NSDictionary alloc] initWithObjects:arr forKeys:keys];
    
}

- (IBAction)pay:(id)sender {
    
    NSString *orderString = self.payInfo;
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"LLxiaoyuyu" callback:^(NSDictionary *resultDic) {
        
        if ([resultDic[@"resultStatus"] intValue] == 9000 || [resultDic[@"resultStatus"] intValue] == 8000) {
            NSLog(@"支付成功");
            
        }else if ([resultDic[@"resultStatus"] intValue] == 6001) {
            NSLog(@"支付取消");
        }else if ([resultDic[@"resultStatus"] intValue] == 6002) {
            NSLog(@"支付失败");
        }else {
            NSLog(@"支付成功");
        }
    }];
    
}


@end
