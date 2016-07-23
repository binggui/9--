//
//  NewsModel.m
//  1-网易新闻
//
//  Created by 付丙贵 on 16/7/21.
//  Copyright © 2016年 jake. All rights reserved.
//

#import "NewsModel.h"
#import "NetWorkTool.h"

@implementation NewsModel

+(instancetype)NewsModelWithDic:(NSDictionary *)dic{

    NewsModel *model = [[NewsModel alloc]init];
    [model setValuesForKeysWithDictionary:dic];
    
    return model;

}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

+(void)downloadWithUrlstr:(NSString *)urlstr  successBlock :(void (^)(NSArray *arr))successBlock  failBlock:(void (^)(NSError *error))failBlock{

    [[NetWorkTool sharedNetWorkTool]GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        
//        NSLog(@"%@",responseObject);
    
        NSString *key = responseObject.keyEnumerator.nextObject;
        
        NSArray *arr = [responseObject objectForKey:key];
        
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
        
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NewsModel *model = [self NewsModelWithDic:obj];
            
            [arrM addObject:model];
            
        }];
        
        if(successBlock){
            successBlock(arrM.copy);
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        if (failBlock) {
            failBlock(error);
        }
        
    }];


}

































@end
