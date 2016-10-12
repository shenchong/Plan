//
//  HomeViewController.m
//  Planist
//
//  Created by easemob on 16/9/22.
//  Copyright © 2016年 沈冲. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIView *headerView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //if 使tabBarController中管理的viewControllers都符合 UIRectEdgeNone
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self setScrollView];
}

- (void)setScrollView{
    
    NSArray *imageArray = @[@"header.jpg",@"header.jpg",@"header.jpg"];
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    
    //轮播图
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    _scrollView.delegate = self;
    int width = self.scrollView.frame.size.width;
    int height = self.scrollView.frame.size.height;

    for (int i = 0; i < imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:imageArray[i]];
        int left = i * width;
        int top = 0;
        imageView.frame = CGRectMake(left, top, width, height);
//        [self.scrollView insertSubview:imageView atIndex:0];
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(imageArray.count * width, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;

    self.pageControl = [[UIPageControl alloc]init];
    _pageControl.numberOfPages = imageArray.count;
    _pageControl.centerX = _headerView.centerX;
    _pageControl.centerY = _scrollView.height-10;
    _pageControl.currentPage = 0;
    _pageControl.tintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    [self addTimer];
    
    [_headerView addSubview:_scrollView];
    [_headerView addSubview:_pageControl];
    [_headerView bringSubviewToFront:_pageControl];
    
    
    //功能列表
    UIView *functionView = [[UIView alloc]initWithFrame:CGRectMake(0, 210, kScreenWidth, 80)];
    [_headerView addSubview:functionView];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    view.backgroundColor = [UIColor grayColor];
    [functionView addSubview:view];
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 80, kScreenWidth, 1)];
    view2.backgroundColor = [UIColor grayColor];
    [functionView addSubview:view2];
    
    NSArray *arrayTemp = @[@"约会",@"礼物",@"物品"];
    
    for (int i = 0; i < 3; ++i) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*(kScreenWidth/3), 15, kScreenWidth/3, 50)];
        [btn setTitle:arrayTemp[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [functionView addSubview:btn];
        if (i>0) {
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i*(kScreenWidth/3), 0, 1, 80)];
            view.backgroundColor = [UIColor grayColor];
            [functionView addSubview:view];
        }
    }
    
    //头条
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _tableView.tableHeaderView = _headerView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)addTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    [loop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)changeImage {
    NSInteger currentIndex = self.pageControl.currentPage;
    if(currentIndex == self.pageControl.numberOfPages - 1) {
        currentIndex = 0;
    } else {
        currentIndex ++;
    }
    int width = self.scrollView.frame.size.width;
    // self.scrollView.contentOffset = CGPointMake(currentIndex * width, 0);
    CGPoint point = CGPointMake(currentIndex * width, 0);
    [self.scrollView setContentOffset:point animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor redColor];
    cell.textLabel.text = @"首页";
    
    return cell;
}


#pragma mark - 代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int width = scrollView.frame.size.width;
    int index = (self.scrollView.contentOffset.x + width / 2)
    / self.scrollView.frame.size.width;
    self.pageControl.currentPage = index;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    [self addTimer];
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
