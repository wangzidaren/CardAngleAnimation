//
//  CardAngleView.h
//  CardAngleAnimation
//
//  Created by tracy on 15-1-22.
//  Copyright (c) 2015年 tracy wang. All rights reserved.
//

#import <UIKit/UIKit.h>

//
@interface CardAngleView : UIView
{


    //bgview
    UIView *_bgView;
    
    //旋转的方向
    float _rotationDirection;

    float originY;

}


//初始化函数
-(id) initViewWithFrame:(CGRect)frame view:(UIView *)view;

- (void)show;

- (void)dismiss;

//外部写入的view，可以把自己定义的view加进来
@property(retain,nonatomic) UIView *contentView;

//背景view透明度
@property(assign,nonatomic) float bgAlpha;

//动画持续时间
@property(assign,nonatomic) float animationDuration;

@end
