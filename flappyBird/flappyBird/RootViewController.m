//
//  RootViewController.m
//  flappyBird
//
//  Created by qianfeng on 15-2-27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RootViewController.h"
#import "GameViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

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
    [self customUI];
}

-(void)customUI
{
    //开始底部图片
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    imageView.image=[UIImage imageNamed:@"bg.jpg"];
    [self.view addSubview:imageView];
    [imageView release];
    
    UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    imageView1.image=[UIImage imageNamed:@"menu"];
    [self.view addSubview:imageView1];
    [imageView1 release];
    
    //动画
    NSMutableArray *images=[[NSMutableArray alloc]init];
    UIImageView *imageViews=[[UIImageView alloc]initWithFrame:CGRectMake(140, 180, 40, 32)];
    NSArray *array=@[@"bird1",@"bird2",@"bird3"];
    for (NSInteger i=0; i<array.count; i++) {
        UIImage *image=[UIImage imageNamed:array[i]];
        [images addObject:image];
    }
    imageViews.animationImages=images;
    imageViews.animationDuration=1;
    imageViews.animationRepeatCount=0;
    [imageViews startAnimating];
    [self.view addSubview:imageViews];
    [images release];
    [imageViews release];
    
    //创建开始按钮
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(30, 340, 120, 66);
    [button setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    //点击事件
    [button addTarget:self action:@selector(onButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}
//开始点击，
-(void)onButtonClick
{
    NSLog(@"ff");
    GameViewController *vc=[[GameViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    [vc release];
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
