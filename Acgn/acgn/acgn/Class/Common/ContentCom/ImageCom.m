//
//  ImageCom.m
//  acgn
//
//  Created by lijian on 2018/2/8.
//  Copyright © 2018年 Jian LI. All rights reserved.
//

#import "ImageCom.h"
#import "JLPhotoBrowser.h"
@interface ImageCom()
@property (nonatomic, strong) UIImageView *bigImageView;
@property (nonatomic, strong) UIImageView *bigSourceImageView;

@property (nonatomic, strong) UIImageView *videoIconView;
@property (nonatomic, strong) UIView *smallImageView;

@property (nonatomic, assign) CGFloat bWidth;
@property (nonatomic, assign) CGFloat bHeight;
@property (nonatomic, assign) CGFloat sWidth;
@property (nonatomic, assign) CGFloat sHeight;
@property (nonatomic, assign) CGFloat sSpace;

@property (nonatomic, assign) CGFloat frameWidth;
@property (nonatomic, assign) CGFloat frameHight;
/**
 *  imageViews
 */
@property (nonatomic,strong) NSMutableArray *imageViews;
/**
 *  URL数组
 */
@property (nonatomic,strong) NSMutableArray *bigImgUrls;

@end

@implementation ImageCom
- (id)initWithBigImage:(CGFloat)width
        bigImageHeight:(CGFloat)height
       smallImageWidth:(CGFloat)swidth
      samllImageHeight:(CGFloat)sheight
            smallSpace:(CGFloat)sspace
                frameW:(CGFloat)frameW
                frameH:(CGFloat)frameH {
    self = [super init];
    if (self) {
        self.bWidth = width;
        self.bHeight = height;
        self.sWidth = swidth;
        self.sHeight = sheight;
        self.sSpace = sspace;
        self.frameHight = frameH;
        self.frameWidth = frameW;
        [self initSubViewsForImage];
    }
    return self;
}

- (void)configImageCom:(NSArray *)array height:(CGFloat)height {
    [self.bigImgUrls removeAllObjects];
    [self.imageViews removeAllObjects];
    if (![array isKindOfClass:[NSArray class]] || OBJ_IS_NIL(array) || array.count == 0) {
        NSLog(@"进来了 = %@", array);
        self.smallImageView.frame = CGRectZero;
        self.bigImageView.frame = CGRectZero;
        self.smallImageView.hidden = YES;
        self.bigImageView.hidden = YES;
        return;
    }
    
    [self.bigImgUrls addObjectsFromArray: array];
    self.smallImageView.frame = CGRectMake(0, 0, self.smallImageView.frame.size.width, height);
    
    NSInteger imageCount = [array count];
    if (imageCount > 0) {
        if (imageCount == 1) {
            self.bigImageView.frame = CGRectMake(0, 0, self.bigImageView.frame.size.width, height);
            self.smallImageView.hidden = YES;
            self.bigImageView.hidden = NO;
            NSString *url = [array firstObject];
            NSString * imageUrl = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            //[self.bigImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@""]];
            [self displaySourceImage:imageUrl];
            
            [self.imageViews addObject:self.bigImageView];
            self.bigImageView.userInteractionEnabled = YES;
            //2.添加手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
            [_bigImageView addGestureRecognizer:tap];
            
            
        } else {
            self.bigImageView.frame = CGRectMake(0, 0, self.bigImageView.frame.size.width, 0);
            self.smallImageView.hidden = NO;
            self.bigImageView.hidden = YES;
            for(UIView *view in [self.smallImageView subviews]) {
                [view removeFromSuperview];
            }
            [self initSmallImages:array.count];
            for (int i = 0; i < imageCount; i ++) {
                UIImageView *iV = [self.smallImageView viewWithTag:1000+i];
                NSString *url = [array objectAtIndex:i];
                NSString * imageUrl = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                [iV sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
            }
        }
    } else {
        self.smallImageView.frame = CGRectZero;
        self.bigImageView.frame = CGRectZero;
    }
}

- (void)displaySourceImage:(NSString *)url {
    WS(weakSelf);
    __weak __typeof(&*self.bigSourceImageView) weakImageView = self.bigSourceImageView;
    [self.bigSourceImageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageAvoidAutoSetImage progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            //do something.....
            dispatch_async(dispatch_get_main_queue(), ^{
                __typeof(&*weakImageView) strongImageView = weakImageView;
                if (strongImageView) {
                    if (image != nil) {
                        if (image.size.width >= image.size.height) {
                            //横着的长方形或者正方形
                            CGFloat viewH = (image.size.height)/(image.size.width)*(weakSelf.bWidth);
                            strongImageView.frame = CGRectMake(0, 0, weakSelf.bWidth, viewH);
                        } else {
                            //竖着的长方形
                            CGFloat viewW = (image.size.width)/(image.size.height)*(weakSelf.bHeight);
                            strongImageView.frame = CGRectMake(0, 0, viewW, weakSelf.bHeight);
                        }
                        NSLog(@"dddd = %f", strongImageView.frame.size.height);
                        strongImageView.image = image;
                        [strongImageView setNeedsLayout];
                    }
                    
                }
            });
        });
    }];
}

- (void)initSubViewsForImage {
    
    self.smallImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frameWidth, self.frameHight)];
    self.smallImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.smallImageView];
    
    self.bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bWidth, self.bHeight)];
    self.bigImageView.tag = 1000;
    self.bigImageView.clipsToBounds = YES;
    self.bigImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.bigImageView];
    
    self.bigSourceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.bigSourceImageView.tag = 9999;
    self.bigSourceImageView.clipsToBounds = YES;
    self.bigSourceImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.bigImageView addSubview:self.bigSourceImageView];
    
    self.smallImageView.hidden = YES;
    self.bigImageView.hidden = YES;
}

- (void)initSmallImages:(NSInteger)count {
    CGFloat XX = _sSpace;
    CGFloat YY = _sSpace;
    for (int i = 0; i < count; i++) {
        if (i%3 == 0) {
            XX = _sSpace;
        } else {
            XX = _sSpace*i+_sSpace+_sWidth*i;
        }
        if (i/3 == 0) {
            YY = _sSpace;
        } else {
            YY = _sSpace*(i/3)+_sSpace+_sHeight*(i/3);
        }
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(XX, YY, _sWidth, _sHeight)];
        imageV.tag = 1000+i;
        imageV.clipsToBounds = YES;
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.userInteractionEnabled = YES;
        [self.smallImageView addSubview:imageV];
        //2.添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
        [imageV addGestureRecognizer:tap];
        
        [self.imageViews addObject:imageV];
    }
}

#pragma mark 图片点击

-(void)imageTap:(UITapGestureRecognizer *)tap{
    
    //1.创建JLPhoto数组
    NSMutableArray *photos = [NSMutableArray array];
    
    for (int i=0; i<self.imageViews.count; i++) {
        
        UIImageView *child = self.imageViews[i];
        JLPhoto *photo = [[JLPhoto alloc] init];
        //1.1设置原始imageView
        photo.sourceImageView = child;
        //1.2设置大图URL
        photo.bigImgUrl = self.bigImgUrls[i];
        //1.3设置图片tag
        photo.tag = i;
        [photos addObject:photo];
        
    }
    
    //2. 创建图片浏览器
    JLPhotoBrowser *photoBrowser = [JLPhotoBrowser photoBrowser];
    //2.1 设置JLPhoto数组
    photoBrowser.photos = photos;
    //2.2 设置当前要显示图片的tag
    photoBrowser.currentIndex = (int)tap.view.tag-1000;
    //2.3 显示图片浏览器
    [photoBrowser show];
}

- (NSMutableArray *)imageViews {
    if (_imageViews==nil) {
        _imageViews = [NSMutableArray array];
    }
    return _imageViews;
}

- (NSMutableArray *)bigImgUrls {
    if (_bigImgUrls==nil) {
        _bigImgUrls = [NSMutableArray array];
    }
    return _bigImgUrls;
}

@end















