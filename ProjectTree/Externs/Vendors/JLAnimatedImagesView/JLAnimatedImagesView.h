//
//  JLAnimatedImagesView.h
//  JL-SDK
//
//  Created by Jasy on 16/1/6.
//  Copyright © 2016年 Jasy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JLAnimatedImagesViewDefaultTimePerImage 20.0f
typedef NS_ENUM(NSUInteger, JLAnimatedType) {
    /*!
     平移
     */
    JLAnimatedType_Translation = 1,
    
    /*!
     变大
     */
    JLAnimatedType_Largen
};
@protocol JLAnimatedImagesViewDelegate;

@interface JLAnimatedImagesView : UIView

@property (nonatomic, assign) id<JLAnimatedImagesViewDelegate>delegate;

@property (nonatomic, assign) NSTimeInterval timePerImage;

- (void)startAnimating:(JLAnimatedType)type;
- (void)stopAnimating;
- (void)reloadData;

@end


@protocol JLAnimatedImagesViewDelegate <NSObject>

- (NSInteger)animatedImagesNumberOfImages:(JLAnimatedImagesView *)animatedImagesView;
- (UIImage *)animatedImagesView:(JLAnimatedImagesView *)animatedImagesView imageAtImdex:(NSInteger)index;

@end