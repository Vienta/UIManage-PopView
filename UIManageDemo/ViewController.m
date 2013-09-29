//
//  ViewController.m
//  UIManageDemo
//
//  Created by 束 永兴 on 13-9-28.
//  Copyright (c) 2013年 Candy. All rights reserved.
//

#import "ViewController.h"
#import "PopView.h"
#import "UIManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)test:(id)sender
{
    PopView *pop = [[PopView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    pop.backgroundColor = [UIColor greenColor];
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    b.frame = CGRectMake(0, 0, 40, 40);
    b.backgroundColor = [UIColor blueColor];
    
    [pop addSubview:b];
    [b addTarget:self action:@selector(tapb:) forControlEvents:UIControlEventTouchUpInside];
    
    [[UIManager shareUIManger] popViewAbsorbLastPopHidden:pop];
}
- (void)tapb:(id)sender
{
    [[UIManager shareUIManger] dismissCurPopView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(0, 0, 60, 40);
    btn.center = CGPointMake(200, 200);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
//    NSLog(@"touches:%@", touches);
}



@end
