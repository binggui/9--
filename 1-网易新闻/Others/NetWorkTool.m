//
//  NetWorkTool.m
//  1-网易新闻
//
//  Created by 付丙贵 on 16/7/21.
//  Copyright © 2016年 jake. All rights reserved.
//

#import "NetWorkTool.h"

@implementation NetWorkTool
+(instancetype )sharedNetWorkTool{
    static id _instancetype;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *baseUrl = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        
        _instancetype = [[self alloc]initWithBaseURL:baseUrl];
        
        
    });
    return _instancetype;

}
@end
