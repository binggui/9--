//
//  CycleCollectionViewCell.m
//  1-网易新闻
//
//  Created by 付丙贵 on 16/7/22.
//  Copyright © 2016年 jake. All rights reserved.
//

#import "CycleCollectionViewCell.h"
#import <UIImageView+WebCache.h>


@interface CycleCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *MyImageView;

@property (weak, nonatomic) IBOutlet UILabel *ListLab;


@end

@implementation CycleCollectionViewCell

-(void)setModel:(CycleModel *)model{


    _model = model;
    [self.MyImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    self.ListLab.text = model.title;
    

}





























@end
