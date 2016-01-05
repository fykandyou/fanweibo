//
//  CyNewFeatureController.m
//  CZ微博fan
//
//  Created by qingyun on 15/12/24.
//  Copyright © 2015年 cyfan. All rights reserved.
//

#import "CyNewFeatureController.h"
#import "CyNewFeatureCell.h"
#import "UIView+Frame.h"
@interface CyNewFeatureController ()
@property(nonatomic,strong) UIPageControl *pageControl;
@end

@implementation CyNewFeatureController

static NSString *reuseIdentifier = @"Cell";


-(instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //cell的尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    
    //清空行距
    layout.minimumLineSpacing = 0;
    //滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [super initWithCollectionViewLayout:layout];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册，默认就会使用这个类的cell
    [self.collectionView registerClass:[CyNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //设置分页
    self.collectionView.pagingEnabled = YES;
    //取消弹性
    self.collectionView.bounces = NO;
    //将下方的水平条取消
    self.collectionView.showsHorizontalScrollIndicator = NO;
    //设置分页
    [self setupPageControl];
}

-(void)setupPageControl{
    UIPageControl *control = [[UIPageControl alloc] init];
    
    control.numberOfPages = 4;
    control.pageIndicatorTintColor = [UIColor blackColor];
    control.currentPageIndicatorTintColor = [UIColor redColor];
    
    control.center = CGPointMake(self.view.width * 0.5, self.view.height);
    _pageControl = control;
    [self.view addSubview:control];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = scrollView.contentOffset.x / self.view.width+ 0.5;
    
    _pageControl.currentPage = page;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CyNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",indexPath.row+1];
    if (screenH > 480) {
        imageName = [NSString stringWithFormat:@"new_feature_%ld-568h",indexPath.row + 1];
    }
    
    cell.image = [UIImage imageNamed:imageName];
    [cell setIndex:indexPath count:4];
    
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
