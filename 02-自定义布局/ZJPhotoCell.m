//
//  ZJPhotoCell.m
//  02-自定义布局
//
//  Created by zijia on 3/27/.
//  Copyright (c) 2016 zijia. All rights reserved.
//

#import "ZJPhotoCell.h"

@interface ZJPhotoCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ZJPhotoCell

- (void)awakeFromNib {
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.borderWidth = 7;
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = [imageName copy];
//    _imageName = imageName;
    
    self.imageView.image = [UIImage imageNamed:imageName];
}

@end
