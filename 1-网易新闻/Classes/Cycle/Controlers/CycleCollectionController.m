//
//  CycleCollectionController.m
//  1-网易新闻
//
//  Created by 付丙贵 on 16/7/22.
//  Copyright © 2016年 jake. All rights reserved.
//

#import "CycleCollectionController.h"
#import "CycleModel.h"
#import "CycleCollectionViewCell.h"

@interface CycleCollectionController ()
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) NSArray * listArr;
@property (strong, nonatomic) UIPageControl * pageControl;
@end

@implementation CycleCollectionController

static NSString * const reuseIdentifier = @"Cell";

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.flowLayout.itemSize = self.collectionView.bounds.size;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self  loadCycleModeData];
    
    [self  loadPagingControl];
    
}



-(void)loadPagingControl{
    
    self.pageControl = [[UIPageControl alloc]init];
    [self.view addSubview:self.pageControl];
    
    //选中颜色
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    //未选中的颜色
    self.pageControl.pageIndicatorTintColor = [UIColor blackColor];
    
    

}

-(void)loadCycleModeData{
    
    

    [CycleModel loadWithUrl:@"ad/headline/0-4.html" successBlock:^(NSArray *listArr) {
        
        self.listArr = listArr;
        
        [self.collectionView reloadData];
        
        //设置pageControl
        self.pageControl.numberOfPages = self.listArr.count;
        
        //size
        CGSize pageContorlSize = [self.pageControl sizeForNumberOfPages:self.listArr.count];
        
        //frame
        CGFloat pageX = self.view.bounds.size.width - pageContorlSize.width - 10;
        CGFloat pageY = self.view.bounds.size.height - pageContorlSize.height;
        
        self.pageControl.frame = CGRectMake(pageX, pageY, pageContorlSize.width, pageContorlSize.height);

        
        //刷新之后,把items滚到第四个
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.listArr.count inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
        
        
    } failBlock:^(NSError *error) {
        NSLog(@"error %@",error);
    }];
    


}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    //计算到第几个item
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    //设置page跟着滚动
    self.pageControl.currentPage = index % self.listArr.count;
    
    //准备索引
    NSIndexPath *indexPath;
    //计算item的总个数
    NSInteger items = [self.collectionView numberOfItemsInSection:0];
    
    //滚到最前面时
    if (index == 0) {
        indexPath = [NSIndexPath indexPathForItem:self.listArr.count inSection:0];
        
    }
    //滚到最后时时
    else if (index == items - 1){
        indexPath = [NSIndexPath indexPathForItem:self.listArr.count - 1 inSection:0];
        
    }

    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>





- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listArr.count *2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CycleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ListCell" forIndexPath:indexPath];
   
    CycleModel *model = self.listArr[indexPath.item % self.listArr.count];
    
    cell.model = model;
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
