//
//  HomeCollectionViewCell.m
//  1-网易新闻
//
//  Created by 付丙贵 on 16/7/19.
//  Copyright © 2016年 jake. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "NewsTableViewController.h"


@interface  HomeCollectionViewCell()

@property (strong, nonatomic) NewsTableViewController * newsVC;

@end
@implementation HomeCollectionViewCell
-(void)awakeFromNib{

    [super awakeFromNib];
    //增加全局忽略文件
    UIStoryboard *newsStoryboard = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    
//    asda
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.newsVC = [newsStoryboard  instantiateInitialViewController];
    
//    self.newsVC.tableView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    
    [self.contentView addSubview:self.newsVC.tableView];
    
    self.newsVC.tableView.frame = self.contentView.frame;
    
    


}

-(void)setUrlString:(NSString *)urlString{
    
    
    _urlString = urlString;
    self.newsVC.urlString = urlString;

}

@end






































