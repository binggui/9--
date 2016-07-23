//
//  NewsTableViewCell.m
//  1-网易新闻
//
//  Created by 付丙贵 on 16/7/21.
//  Copyright © 2016年 jake. All rights reserved.
//

#import "NewsTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface NewsTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *ImageviewIcon;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *sourceLab;

@property (weak, nonatomic) IBOutlet UILabel *replyLab;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imagesViews;

@end

@implementation NewsTableViewCell




-(void)setModel:(NewsModel *)model{

    _model = model;
    
    [self.ImageviewIcon sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    self.titleLab.text = model.title;
    self.sourceLab.text = model.source;
    self.replyLab.text = [NSString stringWithFormat:@"%@",model.replyCount];
    
    for (int i = 0 ; i < model.imgextra.count; i++) {
        //取出控件
        UIImageView *img = self.imagesViews[i];
        
        //取出数据
        NSDictionary *dic = model.imgextra[i];
        
        NSString *imgsrc = [dic objectForKey:@"imgsrc"];
        
        //赋值
        [img sd_setImageWithURL:[NSURL URLWithString:imgsrc]];
        
        
    }
    
    
    


}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}













@end
