//
//  GameViewController.m
//  flappyBird
//
//  Created by qianfeng on 15-2-27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "GameViewController.h"
#import "GameoverViewController.h"
#import "RootViewController.h"
@interface GameViewController ()

@end

@implementation GameViewController
{
    UIImageView *imageView1;
    NSTimer *timer;
    BOOL set;
    CGRect frame1;
    UIImageView *imageView2;
    NSInteger number,columnNumber;
    UIImageView *column1;
    UIImageView *column2;
    CGRect frameColumn1;
    UILabel *columnLabel;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self onstomUI];
}
-(void)onstomUI
{
    //底图
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    imageView.image=[UIImage imageNamed:@"02"];
    [self.view addSubview:imageView];
    [imageView release];
    
    //底部图片
    imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 400,336, 112)];
    imageView1.image=[UIImage imageNamed:@"03"];
    [self.view addSubview:imageView1];
    //[self.view bringSubviewToFront:imageView1];
    [imageView1 release];
    
    
    //小鸟动画
    NSMutableArray *images=[[NSMutableArray alloc]init];
    for (NSInteger i=1; i<=3; i++) {
        NSString *name=[NSString stringWithFormat:@"bird%d",i];
        UIImage *image=[UIImage imageNamed:name];
        [images addObject:image];
    }
    imageView2=[[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 39, 30)];
    imageView2.animationDuration=1;
    imageView2.animationImages=images;
    imageView2.animationRepeatCount=0;
    [imageView2 startAnimating];
    [self.view addSubview:imageView2];
    [imageView2 release];
    [images release];
    frame1=imageView2.frame;
    set=NO;
    
    //第一次柱子动画
    [self column];
    
    //添加手势
    UIImageView *imageView3=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    imageView3.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap)];
    [imageView3 addGestureRecognizer:tap];
    [self.view addSubview:imageView3];
    [imageView3 release];
    [tap release];
    number=0;

    //计时器
    timer=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    
    columnNumber=0;
    //已过柱子计数法及显示
    columnLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 400)];
    columnLabel.text=[NSString stringWithFormat:@"%d",columnNumber];
    columnLabel.textAlignment=NSTextAlignmentCenter;
    columnLabel.font=[UIFont boldSystemFontOfSize:500];
    columnLabel.textColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    [self.view addSubview:columnLabel];
    [self.view insertSubview:columnLabel atIndex:2];
}

-(void)column
{
    //柱子图像
//    NSInteger tall=arc4random()%200+20;
//    column1=[[UIImageView alloc]initWithFrame:CGRectMake(320, -20, 70, tall)];
//    column1.image=[UIImage imageNamed:@"pipe"];
//    [self.view addSubview:column1];
//    [column1 release];

    NSInteger tall = 100;
    
    column2=[[UIImageView alloc]initWithFrame:CGRectMake(320, tall+80, 70, 400)];
    column2.image=[UIImage imageNamed:@"pipe"];
    [self.view addSubview:column2];
    [column2 release];
    //把底部图片视图放在柱子视图上面
    [self.view insertSubview:imageView1 aboveSubview:column2];
}

-(void)onTimer
{
    NSLog(@"hh");
    //底部动画移动
          CGRect frame=imageView1.frame;
    if (frame.origin.x==-15) {
        frame.origin.x=0;
    }
    frame.origin.x--;
    imageView1.frame=frame;
    //上升
    if (set==NO) {
        CGRect frame=imageView2.frame;
        frame.origin.y-=3;
        number+=3;
        imageView2.frame=frame;
        if (number>=60) {
            set=YES;
        }
    }
     //下降
//    if(set==YES&&imageView2.frame.origin.y<370){
//        CGRect frame=imageView2.frame;
//        frame.origin.y++;
//        number-=2;
//        imageView2.frame=frame;
//        number=0;
//    }
     //柱子移动
//    frameColumn1=column1.frame;
    CGRect frameColumn2=column2.frame;
//    frameColumn1.origin.x--;
    frameColumn2.origin.x--;
//    column1.frame=frameColumn1;
    column2.frame=frameColumn2;
//    if (frameColumn1.origin.x<-70) {
//        [self column];
//    }
    //碰撞（交集）
//    bool ret1=CGRectIntersectsRect(imageView2.frame, column1.frame);
    bool ret2=CGRectIntersectsRect(imageView2.frame, column2.frame);
    if (
//        ret1==true
//        ||
        ret2==true
        ) {
        [self onStop];
    }
    if (frameColumn1.origin.x==100+30-70) {
        [self columnLabelClick];
    }
}

-(void)columnLabelClick
{

    if (frameColumn1.origin.x==100+30-70) {
        columnNumber++;
        columnLabel.text=@"";
        columnLabel.text=[NSString stringWithFormat:@"%d",columnNumber];
    }
    [columnLabel release];
}

-(void)onStop
{
    [timer setFireDate:[NSDate distantFuture]];//found 找到
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"提示" delegate:self cancelButtonTitle:@"再来一局" destructiveButtonTitle:@"难度" otherButtonTitles:@"退出游戏",nil];
    [action showInView:self.view];
    [action release];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex//click:点击
{
    if (buttonIndex==2) {
        //再来一局
        NSLog(@"再来一局");
        RootViewController *vc=[[RootViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
        [vc release];
           }else if (buttonIndex==0){
        //难度页面
        GameoverViewController *vc=[[GameoverViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
        [vc release];
    } else {
        //结束游戏
        NSLog(@"Gameover");
    }
}
-(void)onTap
{
    NSLog(@"zz");
    set=NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
