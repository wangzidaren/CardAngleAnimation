//
//  ViewController.m
//  CardAngleAnimation
//
//  Created by tracy on 15-1-22.
//  Copyright (c) 2015年 tracy wang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{

    
    UIView *_myContentView;
    
    CardAngleView *_cardView;


}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    UIButton *_showButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_showButton setFrame:CGRectMake(100, 400, 100, 45)];
    [_showButton addTarget:self action:@selector(showpressed:) forControlEvents:UIControlEventTouchUpInside];
    [_showButton setTitle:@"Show" forState:UIControlStateNormal];
    [_showButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_showButton];
    
    
    _myContentView=[[UIView alloc] init];
    _myContentView.frame=CGRectMake(0, 0, 300, 200);
    _myContentView.backgroundColor=[UIColor colorWithRed:230.0/255.0 green:47.0/255.0 blue:23.0/255.0 alpha:1];
    _myContentView.userInteractionEnabled=YES;

    
    UILabel *tishiLabel=[[UILabel alloc] init];
    [tishiLabel setFrame:CGRectMake(0, 20, _myContentView.frame.size.width, 40)];
    [tishiLabel setText:@"wangzidaren"];
    [tishiLabel setBackgroundColor:[UIColor clearColor]];
    [tishiLabel setTextColor:[UIColor whiteColor]];
    [tishiLabel setFont:[UIFont systemFontOfSize:25]];
    [tishiLabel setTextAlignment:NSTextAlignmentCenter];
    [_myContentView addSubview:tishiLabel];
    [tishiLabel release];

    
    UIButton *_hideButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [_hideButton setFrame:CGRectMake(0, _myContentView.frame.size.height-45, _myContentView.frame.size.width, 45)];
    [_hideButton setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    [_hideButton addTarget:self action:@selector(hidepressed:) forControlEvents:UIControlEventTouchUpInside];
    [_hideButton setTitle:@"Hide" forState:UIControlStateNormal];
    [_hideButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_myContentView addSubview:_hideButton];

    
    
    _cardView=[[CardAngleView alloc] initViewWithFrame:self.view.frame view:_myContentView];
    [self.view addSubview:_cardView];
    
    

}

-(void) showpressed:(id)sender
{


    
    [_cardView show];
    
    


}

-(void) hidepressed:(id)sender
{


    [_cardView dismiss];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    
    [_cardView release];
    
    
    [super dealloc];
    
}

@end
