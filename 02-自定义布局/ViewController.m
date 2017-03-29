//
//  ViewController.m
//  02-自定义布局
//
//  Created by zijia on 3/27/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import "ViewController.h"
#import "ZJLineLayout.h"
#import "ZJPhotoCell.h"
#import "ZJCircleCollectionViewLayout.h"

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) UIImageView *imageV;
@property (nonatomic, weak) UICollectionView  *collectionView;



@property (nonatomic, strong) NSMutableArray *imageNames;


@end

@implementation ViewController

static NSString * const ZJPhotoId = @"photo";

- (NSMutableArray *)imageNames
{
    if (!_imageNames) {
        _imageNames = [NSMutableArray array];
        
        for (int i = 0; i<20; i++) {
            [_imageNames addObject:[NSString stringWithFormat:@"%zd", i + 1]];
        }
    }
    
    return _imageNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor blackColor];
    
    CGFloat collectionW = self.view.frame.size.width;
    CGFloat collectionH = self.view.frame.size.height*0.33;
    
    // 创建布局
    ZJLineLayout *layout = [[ZJLineLayout alloc] init];
    layout.itemSize = CGSizeMake(collectionH*0.7, collectionH*0.7);
    
    // 创建CollectionView
    CGRect frame = CGRectMake(0, 0, collectionW, collectionH);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    _collectionView = collectionView;
    
  
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    
    CGFloat margin = 10;
    
    
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.image = [UIImage imageNamed:@"0"];
    [self.view addSubview:imageV];
   
    
    [imageV makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(margin);
        make.right.equalTo(self.view).offset(-margin);
        make.bottom.equalTo(self.view).offset(-margin);
        make.top.equalTo(collectionView.bottom).offset(20);
        
    }];
     self.imageV = imageV;
    
    
    
    
    
    UIButton *la = [UIButton buttonWithType:UIButtonTypeCustom];
    la.backgroundColor = [UIColor blackColor];
    la.alpha = 0.2;
    
    [la setTitle:@"click" forState:UIControlStateNormal];
    [la setTitle:@"" forState:UIControlStateSelected];
//    la. = @"click here to delete";
//    la.view.text = @"choose";
//    la.textAlignment = 1;
    // NSTextAlignmentCenter
    
    [self.view addSubview:la];
    
    [la makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(margin);
        make.right.equalTo(self.view).offset(-margin);
        make.bottom.equalTo(self.imageV.top).offset(0);
        make.top.equalTo(collectionView.bottom).offset(0);
        
    }];
    

        
    [la addTarget:self action:@selector(clicks:) forControlEvents:UIControlEventTouchUpInside];
    

    
    
    
    
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZJPhotoCell class]) bundle:nil] forCellWithReuseIdentifier:ZJPhotoId];
    
    // 继承UICollectionViewLayout
    // 继承UICollectionViewFlowLayout

    
}

- (void)clicks: (UIButton *)la
{
    
    la.selected = !la.selected;
    
    
    if ([self.collectionView.collectionViewLayout isKindOfClass:[ZJLineLayout class]]) {
        
//        la.highlighted = YES;
        
        [self.collectionView setCollectionViewLayout:[[ZJCircleCollectionViewLayout alloc]init] animated:YES];
        
    }else{
//                la.highlighted = NO;
        ZJLineLayout *lay = [[ZJLineLayout alloc]init];
        CGFloat length = self.collectionView.frame.size.height *0.7;
        lay.itemSize = CGSizeMake(length, length);
        [self.collectionView setCollectionViewLayout:lay animated:YES];
    }

    
}



#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZJPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ZJPhotoId forIndexPath:indexPath];
    
    cell.imageName = [NSString stringWithFormat:@"%zd", indexPath.item];
    
//    cell.backgroundColor = [UIColor orangeColor];
//    
//    NSInteger tag = 10;
//    UILabel *label = (UILabel *)[cell.contentView viewWithTag:tag];
//    if (label == nil) {
//        label = [[UILabel alloc] init];
//        label.tag = tag;
//        [cell.contentView addSubview:label];
//    }
//    
//    label.text = [NSString stringWithFormat:@"%zd", indexPath.item];
//    [label sizeToFit];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.collectionView.collectionViewLayout isKindOfClass:[ZJLineLayout class]]) {
        
        
        self.imageV.image = [UIImage imageNamed:@(indexPath.item).stringValue];
        CATransition *anim = [CATransition animation];
        anim.type = @"rippleEffect";
        anim.duration = 1.5;
        [self.imageV.layer addAnimation:anim forKey:nil];

        
    }else{
//        [self.la setText:@"choose to delte"];
        
        [self.imageNames removeObject:self.imageNames[indexPath.item]];
        
//        [self.imageNames removeObjectAtIndex:indexPath.item];
        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];

    }

    
    
    
//    [NSString stringwit]
//    @(indexPath.item)
    
    
}
@end
