//
//  channelModel.m
//  1-网易新闻
//
//  Created by 付丙贵 on 16/7/19.
//  Copyright © 2016年 jake. All rights reserved.
//

#import "channelModel.h"

@implementation channelModel

//KVC

+(instancetype)channelWithDic:(NSDictionary *)dic{

    channelModel *model = [[channelModel alloc]init];
    
    [model setValuesForKeysWithDictionary:dic];
    
    return model;

}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{


}

+(NSArray *)channel{
   
    //获取json 的文件路径
    NSString *path = [[NSBundle mainBundle]pathForResource:@"topic_news.json" ofType:nil];
    //转换二进制
    NSData *data = [NSData dataWithContentsOfFile:path];
    //获取字典
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    //获取数组
    NSArray *arr = dic[@"tList"];
    
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:arr.count];
    
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        channelModel *model = [channelModel channelWithDic:obj];
        
        [arrM addObject:model];
        
        
    }];
    
    [arrM sortUsingComparator:^NSComparisonResult(channelModel *obj1, channelModel *obj2) {
        
        return [obj1.tid compare:obj2.tid];
        
       
    }];
    
    return arrM.copy ;
    
    
}

































@end
