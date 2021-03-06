//
//  MeasurementWeightViewController.m
//  Udong
//
//  Created by wildyao on 15/12/3.
//  Copyright © 2015年 WuYue. All rights reserved.
//

#import "MeasurementWeightViewController.h"
#import "MasterTabBarViewController.h"
#import "EvaluationResultViewController.h"
#import "RulerView.h"
#define RuleAgeInterval 70

@interface MeasurementWeightViewController ()<UIScrollViewDelegate>
@property (nonatomic, assign) double scale;
@property (nonatomic, assign) double interval1;
@property (nonatomic, assign) double interval2;
@property (nonatomic, assign) double interval3;
@property (nonatomic, assign) double interval4;
@property (nonatomic, assign) double interval5;
@property (nonatomic, assign) double interval6;
@property (nonatomic, assign) double interval7;
@property (nonatomic, assign) double imageHeight;
@property (nonatomic, assign) double buttonHeight;
@property (nonatomic, assign) double beginInter;

@property (nonatomic, assign) NSInteger weight;
@end

@implementation MeasurementWeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNumber];
    [self configData];
    [self configView];
}

- (void)configView
{
    
    self.view.backgroundColor = kColorWhiteColor;
    self.stepImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.left+30, self.interval1+25, self.view.right-2*30, 25)];
    self.stepImageView.image = ImageNamed(@"progress-bar_4");
    [self.view addSubview:self.stepImageView];
    
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(10, 35, 23, 23);
    [self.backBtn setBackgroundImage:ImageNamed(@"navbar_icon_back") forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(OnBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];
    
    
    CGSize Size1 = [@"无须日行万步" sizeWithAttributes:@{NSFontAttributeName:FONT(17)}];
    self.label1 = [[UILabel alloc] init];
    self.label1.text = @"无须日行万步";
    self.label1.font = FONT(17);
    self.label1.textColor = kColorBlackColor;
    self.label1.top = self.stepImageView.bottom+_interval2;
    self.label1.width = Size1.width;
    self.label1.height = Size1.height;
    self.label1.centerX = self.stepImageView.centerX;
    [self.view addSubview:self.label1];
    
    CGSize size2 = [@"完成有效运动目标就能促进健康" sizeWithAttributes:@{NSFontAttributeName:FONT(17)}];
    self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(self.label1.centerX, self.label1.bottom+_interval3, size2.width, size2.height)];
    self.label2.numberOfLines = 0;
    self.label2.lineBreakMode = NSLineBreakByWordWrapping;
    self.label2.text = @"完成有效运动目标就能促进健康";
    self.label2.font =  FONT(17);
    self.label2.textColor = kColorBlackColor;
    CGSize size = [self.label2 sizeThatFits:CGSizeMake(self.label2.frame.size.width, MAXFLOAT)];
    self.label2.frame =CGRectMake(self.label1.centerX-(self.label2.width)/2, self.label1.bottom+_interval3, size2.width, size.height);
    
    [self.view addSubview:self.label2];
    
    
    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.top = self.label2.bottom+_interval4-25;
    self.numberLabel.width = 50;
    self.numberLabel.height = 40;
    self.numberLabel.centerX = self.view.centerX;
    self.numberLabel.font = FONT_BOLD(25);
    self.numberLabel.textColor = kColorBlackColor;
    [self.view addSubview:self.numberLabel];
    
    self.hidenLabel = [[UILabel alloc] init];
    self.hidenLabel.top = self.label2.bottom+_interval4-25;
    self.hidenLabel.width = 50;
    self.hidenLabel.height = 40;
    self.hidenLabel.text = @"50";
    self.hidenLabel.centerX = self.view.centerX;
    self.hidenLabel.font = FONT_BOLD(25);
    self.hidenLabel.textColor = kColorBlackColor;
    [self.view addSubview:self.hidenLabel];
    
    self.shengaoLabel = [[UILabel alloc] init];
    self.shengaoLabel.width = 40;
    self.shengaoLabel.height = 40;
    self.shengaoLabel.centerY = self.numberLabel.centerY;
    self.shengaoLabel.right = self.numberLabel.left-20;
    self.shengaoLabel.text = @"体重";
    self.shengaoLabel.textColor = UIColorFromHexWithAlpha(0x999999,1);
    self.shengaoLabel.font = FONT(15);
    [self.view addSubview:self.shengaoLabel];
    
    self.cmabel = [[UILabel alloc] init];
    self.cmabel .width = 40;
    self.cmabel .height = 40;
    self.cmabel .centerY = self.numberLabel.centerY;
    self.cmabel .left = self.numberLabel.right+20;
    self.cmabel .text = @"kg";
    self.cmabel .textColor = UIColorFromHexWithAlpha(0x999999,1);
    self.cmabel .font = FONT(15);
    [self.view addSubview:self.cmabel];
    
    self.pointImageView = [[UIImageView alloc] init];
    self.pointImageView.width = 20;
    self.pointImageView.height = 25;
    self.pointImageView.centerX = self.view.centerX-5;
    self.pointImageView.top = self.numberLabel.bottom+_interval5;
    self.pointImageView.image = ImageNamed(@"icon_indicator");
    [self.view addSubview:self.pointImageView];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.pointImageView.bottom+_interval6, self.view.width, _imageHeight)];
    self.scrollView.backgroundColor = UIColorFromHexWithAlpha(0xEBEBEB,1);
    self.scrollView.contentSize = CGSizeMake(92*RuleAgeInterval, self.scrollView.contentSize.height);
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    RulerView *rulerView = [[RulerView alloc] initWithFrame:CGRectMake(0,0, self.scrollView.contentSize.width, self.scrollView.size.height) width:self.scrollView.contentSize.width length:self.scrollView.size.height count:91+1 interval:RuleAgeInterval dataArray:self.dataArray];
    [self.scrollView addSubview:rulerView];
    [self.view addSubview:self.scrollView];
    
    self.scrollView.contentOffset = CGPointMake(15*RuleAgeInterval+SCREEN_WIDTH/2+_beginInter,0);
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.width = 140;
    self.leftBtn.height = _buttonHeight;
    self.leftBtn.right = self.view.centerX-20;
    self.leftBtn.bottom = self.view.bottom-_interval7;
    [self.leftBtn setTitle:@"上一步" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:kColorBtnColor forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(OnBtnBack:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBtn.layer.borderWidth = 0.5;
    self.leftBtn.layer.borderColor = kColorBtnColor.CGColor;
    self.leftBtn.layer.cornerRadius = self.leftBtn.height/2;
    self.leftBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.leftBtn];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.width = 140;
    self.rightBtn.height = _buttonHeight;
    self.rightBtn.left = self.view.centerX+20;
    self.rightBtn.bottom = self.leftBtn.bottom;
    [self.rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:kColorBtnColor forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(OnBtnToNext:) forControlEvents:UIControlEventTouchUpInside];
    
    self.rightBtn.layer.borderWidth = 0.5;
    self.rightBtn.layer.borderColor = kColorBtnColor.CGColor;
    self.rightBtn.layer.cornerRadius = self.rightBtn.height/2;
    self.rightBtn.layer.masksToBounds = YES;
    [self.view addSubview:self.rightBtn];
    
    
}

- (void)configData
{
    _dataArray = [[NSMutableArray alloc] init];
    for (int i=0; i<91; i++) {
        NSString *dataString = [NSString stringWithFormat:@"%d",i+30];
        [_dataArray addObject:dataString];
    }

}

- (void)OnBtnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)OnBtnToNext:(id)sender
{
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(todoSomething:) object:sender];
    [self performSelector:@selector(todoSomething:) withObject:sender afterDelay:0.3];
    
}

- (void)todoSomething:(id)sender
{
    if (self.scrollView.contentOffset.x == 0) {
        [StorageManager saveWeight:@"50"];
    }else
    {
        if (_weight == 0) {
            [StorageManager saveWeight:@"50"];
        }else
        {
            NSString *weightString = [NSString stringWithFormat:@"%ld",_weight];
            [StorageManager saveWeight:weightString];
        }
    }
    
    [SVProgressHUD showProgressWithStatus:@"请稍候" duration:-1];
    
    [APIServiceManager getEvaluationResultWithKey:[StorageManager getSecretKey] idString:[StorageManager getUserId] sexString:[StorageManager getSex] ageString:[StorageManager getAge] heightString:[StorageManager getHeight] weightString:[StorageManager getWeight] completionBlock:^(id responObject) {
        
        if ([responObject[@"flag"] isEqualToString:@"100100"]) {
            
            [SVProgressHUD dismiss];
            EvaluationResultViewController *EvaluationVC= [[EvaluationResultViewController alloc] init];
            EvaluationVC.pointLabelNumber = responObject[@"eResult"][@"eev"];
            
            NSString *eevString = [NSString stringWithFormat:@"%@",responObject[@"eResult"][@"eev"]];
            [StorageManager saveEffectivepoint:eevString];
            
            EvaluationVC.descriptionString = responObject[@"eResult"][@"methodDesc"];
            [self.navigationController pushViewController:EvaluationVC animated:YES];
            
        }
        
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    float scale = ((scrollView.contentOffset.x+(SCREEN_WIDTH/2))/RuleAgeInterval);
    if (scale>=10) {
        NSString *string = [NSString stringWithFormat:@"%f",scale];
        NSString *secondString = [NSString stringWithFormat:@"%0.2f",scale];
        NSString *thirdString = [secondString substringFromIndex:3];
        if ([thirdString integerValue]<=57) {
            NSString *ageString = [string substringToIndex:2];
            NSInteger age = 29+[ageString integerValue];
            _weight = age;
        }else{
            NSString *ageString = [string substringToIndex:2];
            NSInteger age =30+[ageString integerValue];
            _weight = age;
        }
        //        NSLog(@"%@--%@",string,thirdString);
    }else{
        NSString *string = [NSString stringWithFormat:@"%f",scale];
        NSString *secondString = [NSString stringWithFormat:@"%0.2f",scale];
        NSString *thirdString = [secondString substringFromIndex:2];
        if ([thirdString integerValue]<=57) {
            NSString *ageString = [string substringToIndex:2];
            NSInteger age = 29+[ageString integerValue];
            _weight = age;
        }else{
            NSString *ageString = [string substringToIndex:2];
            NSInteger age = 30+[ageString integerValue];
            _weight = age;
        }
        //        NSLog(@"%@--%@",string,thirdString);
        
        
    }
    self.hidenLabel.hidden = YES;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)_weight];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float scale = ((scrollView.contentOffset.x+(SCREEN_WIDTH/2))/RuleAgeInterval);
    if (scale>=10) {
        NSString *string = [NSString stringWithFormat:@"%f",scale];
        NSString *secondString = [NSString stringWithFormat:@"%0.2f",scale];
        NSString *thirdString = [secondString substringFromIndex:3];
        if ([thirdString integerValue]<=57) {
            
            NSString *ageString = [string substringToIndex:2];
            NSInteger age = 29+[ageString integerValue];
            _weight = age;
            
            //            NSString *subString = [string substringFromIndex:3];
            //            scrollView.contentOffset.x-=[subString floatValue]*RuleAgeInterval;
            
        }else{
            NSString *ageString = [string substringToIndex:2];
            NSInteger age = 30+[ageString integerValue];
            _weight = age;
        }
        NSLog(@"%@--%@",string,thirdString);
    }else{
        NSString *string = [NSString stringWithFormat:@"%f",scale];
        NSString *secondString = [NSString stringWithFormat:@"%0.2f",scale];
        NSString *thirdString = [secondString substringFromIndex:2];
        if ([thirdString integerValue]<=57) {
            NSString *ageString = [string substringToIndex:2];
            NSInteger age = 29+[ageString integerValue];
            _weight = age;
        }else{
            NSString *ageString = [string substringToIndex:2];
            NSInteger age = 30+[ageString integerValue];
            _weight = age;
        }
        NSLog(@"%@--%@",string,thirdString);
        
        
    }
    self.hidenLabel.hidden = YES;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)_weight];
}


- (void)configNumber
{
    if (IS_IPONE_4_OR_LESS) {
        _interval1 = 50;
        _interval2 = 20;
        _interval3 = 10;
        _interval4 = 40;
        _interval5 = 10;
        _interval6 = 4;
        _interval7 = 40;
        _imageHeight = 70;
        _buttonHeight = 30;
    }else if (IS_IPHONE_5){
        _scale = 568.0/667;
        _interval1 = 58*_scale;
        _interval2 = 30*_scale;
        _interval3 = 21*_scale;
        _interval4 = 94*_scale;
        _interval5 = 22*_scale;
        _interval6 = 7*_scale;
        _interval7 = 72*_scale;
        _imageHeight = 88*_scale;
        _buttonHeight = 45*_scale;
        _beginInter = 105;
    }else if (IS_IPHONE_6){
        _scale = 1;
        _interval1 = 58;
        _interval2 = 30;
        _interval3 = 21;
        _interval4 = 94;
        _interval5 = 22;
        _interval6 = 7;
        _interval7 = 72;
        _imageHeight = 88;
        _buttonHeight = 45;
    }else if (IS_IPHONE_6P){
        _scale = 736/667;
        _interval1 = 58*_scale;
        _interval2 = 30*_scale;
        _interval3 = 21*_scale;
        _interval4 = 94*_scale;
        _interval5 = 22*_scale;
        _interval6 = 7*_scale;
        _interval7 = 72*_scale;
        _imageHeight = 88*_scale;
        _buttonHeight = 45*_scale;
        _beginInter = 11;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
