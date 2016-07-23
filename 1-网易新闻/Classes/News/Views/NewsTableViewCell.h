//
//  NewsTableViewCell.h
//  1-网易新闻
//
//  Created by 付丙贵 on 16/7/21.
//  Copyright © 2016年 jake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsTableViewCell : UITableViewCell
@property (strong, nonatomic) NewsModel * model;
@end
