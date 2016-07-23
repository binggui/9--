//
//  CycleModel.m
//  1-网易新闻
//
//  Created by 付丙贵 on 16/7/22.
//  Copyright © 2016年 jake. All rights reserved.
//

#import "CycleModel.h"
#import "NetWorkTool.h"


@implementation CycleModel
//KVC
+(instancetype)CycleModelWithDic:(NSDictionary *)dic{
   
    CycleModel *model = [[CycleModel alloc]init];
    
    [model setValuesForKeysWithDictionary:dic];
    
    return model;


}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{


}

+(void)loadWithUrl:(NSString *)urlstr successBlock:(void (^)(NSArray *listArr))successBlock failBlock:(void (^)(NSError *error))failBlock{

    [[NetWorkTool sharedNetWorkTool] GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        
        NSString *key = responseObject.keyEnumerator.nextObject;
        
        NSArray *array = [responseObject objectForKey:key];
        
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
        
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CycleModel *model = [self CycleModelWithDic:obj];
            
            [arrayM addObject:model];
            
            
            if (successBlock) {
                successBlock(arrayM.copy);
            }
        }];
        
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        if (failBlock) {
            failBlock(error);
        }
    }];
    

}































@end
