//
//  LLIPHelper.m
//  LLmyApp
//
//  Created by 陈林 on 2022/5/16.
//  Copyright © 2022 ManlyCamera. All rights reserved.
//

#import "LLIPHelper.h"
#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation LLIPHelper

+ (NSString *)getNetworkIPAddress {
    //方式一：淘宝api
    NSURL *ipURL = [NSURL URLWithString:@"http://ip.taobao.com/service/getIpInfo.php?ip=myip"];
    NSData *data = [NSData dataWithContentsOfURL:ipURL];
    NSDictionary *ipDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSString *ipStr = nil;
    if (ipDic && [ipDic[@"code"] integerValue] == 0) {
        //获取成功
        ipStr = ipDic[@"data"][@"ip"];
    }
    return (ipStr ? ipStr : @"0.0.0.0");
}

+ (void)getIPaddress
{
NSString *address = @"error";
struct ifaddrs * ifaddress = NULL;
struct ifaddrs * temp_address = NULL;
int success = 0;
success = getifaddrs(&ifaddress);
if(success == 0) {
temp_address = ifaddress;
while(temp_address != NULL) {
if(temp_address->ifa_addr->sa_family == AF_INET) {
if([[NSString stringWithUTF8String:temp_address->ifa_name] isEqualToString:@"en0"]) {
address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_address->ifa_addr)->sin_addr)];
}
}
temp_address = temp_address->ifa_next;
}
}

NSLog(@"获取到的IP地址为：%@",address);
}

+ (void)awakeFromYNGroupClassLiveHeaderViewWithDate {
//    self.selectedDate = date;
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    //明天时间
    NSDate *tomorrow = [[NSDate alloc] initWithTimeIntervalSinceNow:secondsPerDay];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    NSString *dateStr = [dateFormatter stringFromDate:tomorrow];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:dateStr, @"dayStr", tomorrow, @"date", nil];
    NSLog(@"%@",dict);
//    self.currentModel = [YNGroupClassLiveWeekDateModel modelWithDict:dict];
//    [self.collectionView reloadData];
//    [self setButton];
}

@end
