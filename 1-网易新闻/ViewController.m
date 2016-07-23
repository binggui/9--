//
//  ViewController.m
//  1-网易新闻
//
//  Created by 付丙贵 on 16/7/19.
//  Copyright © 2016年 jake. All rights reserved.
//

#import "ViewController.h"
#import "channelModel.h"
#import "channelLabel.h"
#import "HomeCollectionViewCell.h"


@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *TitleScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowOut;

@property (strong, nonatomic)  NSArray * channelArr;

@property (strong, nonatomic) NSMutableArray * labArr;
@end

@implementation ViewController

-(NSMutableArray *)labArr{


    if (_labArr == nil ) {
        _labArr = [NSMutableArray array];
    }
    return _labArr;
}

-(NSArray *)channelArr{
    if (_channelArr  == nil){
    
        _channelArr =  [channelModel channel];
    }
    return _channelArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self  channelView];
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    //cell的大小和父类一样大
    
    self.flowOut.itemSize = self.collectionView.bounds.size;

}


#pragma mark
#pragma mark - collection的方法实现
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.channelArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
    
    channelModel *model = self.channelArr[indexPath.item];
    NSString *urlStr = [NSString stringWithFormat:@"article/list/%@/0-20.html",model.tid];
    cell.urlString = urlStr;
    
    return cell;

}

//增加label
-(void)channelView{
    
    
    self.channelArr = [channelModel channel];
    
//    NSLog(@"%@",self.channelArr);

    //
    CGFloat labW = 80;
    CGFloat labH = self.TitleScrollView.bounds.size.height;
    
    //循环创建标签
    for (int i = 0 ; i  < self.channelArr.count; i++) {
        channelLabel *label = [[channelLabel alloc]init];
        
        label.tag = i;
        
        [self.TitleScrollView addSubview:label];
        
        channelModel *model = self.channelArr[i];
        label.text  = model.tname;
        
        label.frame = CGRectMake(labW * i, 0 , labW, labH);
        
        
        self.TitleScrollView.contentSize = CGSizeMake(labW * self.channelArr.count, 0);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        
        [label addGestureRecognizer:tap];
        
        label.userInteractionEnabled = YES;
        
        [self.labArr addObject:label];
        
        
    }
    
}

//点击方法
-(void)tapClick:(UITapGestureRecognizer *)tap{


    //获取选中的label
    channelLabel *lab = (channelLabel *)tap.view;
    
    //居中滚动,偏移量
    CGFloat labOffetX = lab.center.x - self.view.bounds.size.width / 2;
    
    CGFloat minOffsetX = 0;
    CGFloat maxOffsetX = self.TitleScrollView.contentSize.width - self.view.bounds.size.width;
    
    
    if (labOffetX < minOffsetX) {
        labOffetX = 0;
    }else if (labOffetX > maxOffsetX){
    
        labOffetX  = maxOffsetX;
    
    }
    
    //滚动
    [self.TitleScrollView setContentOffset:CGPointMake(labOffetX, 0) animated:YES];
    
    //collection 跟着联动
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:lab.tag inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:YES];
    

}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    NSInteger index = scrollView.contentOffset.x / self.view.bounds.size.width;
    
    channelLabel *lab = self.labArr[index];
    
    CGFloat labOffsetX = lab.center.x - self.view.bounds.size.width / 2;
    //最大最小偏移量
    CGFloat minOffsetX = 0 ;
    CGFloat maxOffsetX = self.TitleScrollView.contentSize.width - self.view.bounds.size.width;//self.TitleScrollView.bounds.size.width
    
    if (labOffsetX < minOffsetX) {
        labOffsetX = 0;
    }else if(labOffsetX > maxOffsetX){
        labOffsetX = maxOffsetX;
    
    }
    
    //滚动
    [self.TitleScrollView setContentOffset:CGPointMake(labOffsetX, 0) animated:YES];
    

}



















@end
