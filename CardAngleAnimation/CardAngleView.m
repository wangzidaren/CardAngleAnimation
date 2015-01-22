//
//  CardAngleView.m
//  CardAngleAnimation
//
//  Created by tracy on 15-1-22.
//  Copyright (c) 2015年 tracy wang. All rights reserved.
//

#import "CardAngleView.h"

//最终view显示的角度
#define finalAngle 45


@implementation CardAngleView



-(id)initViewWithFrame:(CGRect)frame view:(UIView *)view
{

    self = [super initWithFrame:frame];

    if (self)
    {
        
        
        self.contentView=view;
        
        
        [self setDefaultValue];
        
        [self initUI];
        
        
    }
    


    return self;

}

-(void) setDefaultValue
{


    _bgAlpha=0.5f;
    
    _animationDuration=0.6f;
    
    self.backgroundColor=[UIColor clearColor];
    
    self.hidden=YES;

}

-(void) initUI
{

    
    _bgView=[[UIView alloc] init];
    _bgView.frame=self.frame;
    _bgView.backgroundColor=[UIColor blackColor];
    _bgView.alpha=_bgAlpha;
    
    [self addSubview:_bgView];
    
    
   
    CGRect newframe=_contentView.frame;
    
    newframe.origin.x=self.frame.size.width/2-_contentView.frame.size.width/2;
    newframe.origin.y=-_contentView.frame.size.height;
    _contentView.frame=newframe;
    
    [self addSubview:_contentView];
    
    //平移手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognizer:)];
    [_contentView addGestureRecognizer:panGesture];
    [panGesture release];

}


-(void) show
{

    self.hidden=NO;
    
    CGFloat y = -(CGRectGetHeight(self.frame) + CGRectGetHeight(_contentView.frame)/2);

    _contentView.center=CGPointMake(_contentView.center.x,y);
    _contentView.transform = CGAffineTransformMakeRotation(finalAngle);


    //spring animation usingSpringWithDamping 的范围为 0.0f 到 1.0f ，数值越小「弹簧」的振动效果越明显 initialSpringVelocity 则表示初始的速度，数值越大一开始移动越快
    [UIView animateWithDuration:_animationDuration
                          delay:0.0
         usingSpringWithDamping:0.9
          initialSpringVelocity:1
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         _contentView.transform = CGAffineTransformMakeRotation(0);
                         _contentView.center = CGPointMake(CGRectGetMidX(self.frame),
                                                         CGRectGetMidY(self.frame));
                     } completion:^(BOOL finished) {
                     }];

}


-(void) dismiss
{
    
    float finalY = self.frame.size.height +_contentView.frame.size.height/2;


    [UIView animateWithDuration:_animationDuration
                          delay:0.0f
         usingSpringWithDamping:1.0f
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         _bgView.alpha = 0;
                         
                         _contentView.transform = CGAffineTransformMakeRotation(finalAngle);
                         _contentView.alpha = 0.0;
                         
                         _contentView.center=CGPointMake(_contentView.center.x,finalY);
                         

                         
                     }
                     completion:^(BOOL finished) {
                        
                         
                         self.hidden=YES;
                         
                         _bgView.alpha=_bgAlpha;
                         _contentView.alpha=1;
                         
                         
                         
                     }];


    

}


- (void)panRecognizer:(UIPanGestureRecognizer *)recognizer
{

    //移动坐标
    CGPoint point=[recognizer translationInView:_contentView];
    //每次的移动量
    [recognizer setTranslation:CGPointZero inView:_contentView];

    
   // NSLog(@"x:%f--y:%f",point.x,point.y);
    
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        CGPoint position =  [recognizer locationInView:_contentView];
        //有没有超过这个frame中心点
        _rotationDirection = position.x > CGRectGetMidX(_contentView.frame) ? 1 : -1;
    } else if(recognizer.state == UIGestureRecognizerStateChanged)
    {
        
        //当前y的位置
        float curY=_contentView.frame.origin.y+point.y;
        
        
        _contentView.center=CGPointMake(_contentView.center.x, curY+_contentView.frame.size.height/2);
        
        
        
        //bgview透明度
        if (point.y>0)
        {
            
            _bgView.alpha=_bgAlpha-curY/self.frame.size.height*_bgAlpha;
            
        }
        
        
       // NSLog(@"%f",_bgView.alpha);
        
      //  NSLog(@"%f",point.y);
        CGFloat curAngle = finalAngle * (M_PI / 180) * (curY/self.frame.size.height) * _rotationDirection;
        _contentView.transform = CGAffineTransformMakeRotation(curAngle);
    
      
        
    }
    else
    {
    
        if (fabs(_contentView.center.y - self.frame.size.height) < (self.frame.size.height / 4))
        {
            [self dismiss];
            
        } else
        {
            
            [UIView animateWithDuration:0.3
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 _bgView.alpha = _bgAlpha;
                                 _contentView.transform = CGAffineTransformMakeRotation(0);
                                 
                                 _contentView.center = CGPointMake(CGRectGetMidX(self.frame),
                                                                   CGRectGetMidY(self.frame));
                             } completion:^(BOOL finished) {
                             }];
            

        }
        
        
    }

    
    
    

}


#pragma set
-(void) setBgAlpha:(float)bgAlpha
{

    _bgView.alpha=bgAlpha;


}


- (void)dealloc
{
    
    
    [_bgView release];
    
    self.contentView=nil;
    
    
    
    [super dealloc];
}






@end
