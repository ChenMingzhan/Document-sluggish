//
//  ViewController.m
//  文件托出效果
//
//  Created by 铭铭 on 16/7/26.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "ViewController.h"

//宏定义屏幕宽度
#define screenWidth self.view.frame.size.width
#define screenHeight self.view.frame.size.height

@interface ViewController ()

//起点
@property (nonatomic, assign) CGPoint startPoint;

//拖拉
@property (nonatomic, strong) UIView *drag;

//拖拉背景
@property (nonatomic, strong) UIView *dragBac;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dragBac = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight/2, screenWidth,screenHeight/2 )];
    
    _dragBac.userInteractionEnabled=YES;
    
    _dragBac.backgroundColor = [UIColor lightGrayColor];
    
    //shadowColor阴影颜色
    _dragBac.layer.shadowColor = [UIColor blackColor].CGColor;
    
    //shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    _dragBac.layer.shadowOffset =CGSizeMake(6, 6);
    
    _dragBac.layer.shadowOpacity = 0.8;
    
    //阴影半径
    _dragBac.layer.shadowRadius =10;
    
    [self.view addSubview:_dragBac];
    
    
    _drag = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight/2, 50, 50)];
    
    _drag.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_drag];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    _startPoint=point;
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    //判断是不是出了左右边界
    point.x = MIN(point.x, screenWidth-25);
    point.x = MAX(point.x, 25);
    
    CGPoint newcenter = CGPointMake(point.x, point.y);
    
    //移动
    _drag.center = newcenter;
    
    if ((point.y+25)<screenHeight/2) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            _dragBac.alpha=0;
        }];
    }
    
    
    if ((point.y+25)>screenHeight) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            _dragBac.alpha=1;
        }];
    }
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    if (((point.y+25)>screenHeight/2 && (point.y-25)<screenHeight/2) || ((point.y+25)>screenHeight&&(point.y-25)<screenHeight)) {
        
        [UIView animateWithDuration:0.5 animations:^{
            _drag.frame=CGRectMake(0, screenHeight/2, 50, 50);
            
        }];
    }
}
@end
