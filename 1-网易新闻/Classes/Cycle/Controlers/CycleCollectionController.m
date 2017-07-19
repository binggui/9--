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
@property (strong, nonatomic) NSTimer * timer;
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
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:NO];
        
        [self timer];
        
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
    
      [self timer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/**
  *  当scorllView滚动的时候会调用这个方法
  *
  */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //计算到第几个item
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    //设置page跟着滚动
    self.pageControl.currentPage = index % self.listArr.count;
}


/**
  *  用户开始拖动scrollView时会调用这个方法
  *
  */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //当用户开始拖动scrollView时，停止定时器
    [self.timer invalidate];

    //定时器一旦被停止，就无法再被唤醒，所以可以把它置为nil
    self.timer = nil;
}



/**
  *  复写timer的get方法
  *
  */
- (NSTimer *)timer{
    
    if(_timer == nil){
    //创建一个定时器。每隔1秒钟自动调用 playPicture 方法
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(playPicture) userInfo:nil repeats:YES];

    //默认的定时器模式不能同时处理定时器和界面，需要把定时器的模式设置为 NSRunLoopCommonModes
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    }
    return _timer;
}




- (void)playPicture{
   
    NSInteger newPage = self.pageControl.currentPage + 1;
    //计算item的总个数
    NSInteger items = [self.collectionView numberOfItemsInSection:0];
    //2.如果当前页是最后一页，将当前页置为0
    if (newPage == items / 2 ) {
        newPage = 0;

    }
    
    //准备索引
    NSIndexPath *indexPath =  [NSIndexPath indexPathForItem:newPage inSection:0];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:0 animated:YES];
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

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{

//    //刷新之后,把items滚到第四个
//    NSIndexPath *indexP = [NSIndexPath indexPathForItem:0 inSection:0];
//    [self.collectionView scrollToItemAtIndexPath:indexP atScrollPosition:0 animated:NO];
//
//    [self timer];
}

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
