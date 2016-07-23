//
//  NewsTableViewController.m
//  1-网易新闻
//
//  Created by 付丙贵 on 16/7/19.
//  Copyright © 2016年 jake. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"

@interface NewsTableViewController ()


@property (strong, nonatomic)  NSArray* dataArr;

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

-(void)setUrlString:(NSString *)urlString{

    [NewsModel downloadWithUrlstr:urlString successBlock:^(NSArray *arr) {
        
        self.dataArr = arr;
        
        //刷新表格
        [self.tableView reloadData];
        
    } failBlock:^(NSError *error) {
        NSLog(@"error %@",error);
        
    }];
    
    

}


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsModel *model = self.dataArr[indexPath.row];
   
    NSString *identifier;
    
    if (model.imgType) {
        
        identifier = @"BigCell";
    }else if (model.imgextra.count == 2){
    
        identifier = @"ImagesCell";
    }else {
    
        identifier = @"BaseCell";
    }
    
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.model = model;
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel *model = self.dataArr[indexPath.row];

    if (model.imgType) {
        return 180;
    }else if (model.imgextra.count == 2){
    
        return 150;
    
    }else{
        
        return 80;
    }
    
}























@end
