//
//  OutVideoPlayViewController.m
//  BeautifulWorld
//
//  Created by fantasy  on 2017/3/27.
//  Copyright © 2017年 fantasy . All rights reserved.
//

#import "OutVideoPlayViewController.h"
#import "CommentTableViewCell.h"
//#import "CommentBar.h"
#import "ActivityShowTableCell.h"
#import "LiveAnimationView.h"
#import "ZXVideo.h"
#import "ZXVideoPlayerController.h"
#import "CustMyFormulateController.h"
#import "UIViewController+LZBKeyBoardObserver.h"
#import "CYAlertView.h"
static NSString * actCellIdent = @"ActivityShowTableCell";

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface OutVideoPlayViewController ()<UITableViewDelegate,UITableViewDataSource,CommentTableViewCellDelegate,CYAlertViewDelegate>{
    UIView * headView;
    UIView * tabHead ;
    UIImageView * video;
     ZXVideoPlayerController *myPlayer;
    UIView * introduceView;
    ActivityShowTableCell * actCell;
    UIView * giftView;
    UIImageView * gift;
    UIImageView * selectedGift;
    NSString * videoid;
    
    NSMutableArray * recommendTitleArr;
    NSMutableArray * recommendTimeArr;
}

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArr;
@property(nonatomic,strong)NSMutableArray * souceArr;
@property (nonatomic, strong) NSIndexPath * indexPath;


@end

@implementation OutVideoPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       NSLog(@"该视频的ID%@",self.videoID);


    self.view.backgroundColor =[UIColor whiteColor];
   
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [FTShowMessageView showStatusWithMessage:@"Loading..."];
    [self initVideo];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;

}
-(void)onShare{
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"标识"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"西安同泽艺术品"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://www.xiantongze.com"]
                                          title:@"美丽新世界"
                                           type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
}


- (void)heartClick
{
    CGRect frame = CGRectMake(0, 0, 40, 40);
    LiveAnimationView *animationView = [[LiveAnimationView alloc] initWithFrame:frame withSuperView:myPlayer.view];
    
    CGPoint center = CGPointMake(self.view.bounds.size.width/2, myPlayer.view.bounds.size.height-30);
    animationView.center = center;
    
    [animationView addAnimationView];
    [myPlayer.view addSubview:animationView];
    
}



#pragma mark - 懒加载
-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataArr;
}
-(NSMutableArray *)souceArr{
    if (_souceArr == nil) {
        _souceArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _souceArr;
}
-(void)createUIWithvideoId:(NSString *)videoId{
    
    
   
   
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kScreen_Height/3+70, kScreen_Width, kScreen_Height -NavBar_Height - StatusBar_Height-kScreen_Height/3)style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    tabHead = [[UIView alloc]init];
    tabHead.frame =CGRectMake(0, 0, kScreen_Width, kScreen_Height/5);
    tabHead.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = tabHead;
    
    UILabel * tuijian =[[UILabel alloc]init];
    tuijian.frame = CGRectMake(20,5, kScreen_Width/3, 20);
    tuijian.font = font15;
    tuijian.text = @"相关视频";
    [tabHead addSubview:tuijian];
    

    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:@([@"3" intValue]) forKey:@"limit"];
    [params setValue:videoId forKey:@"id"];

    recommendTitleArr = [[NSMutableArray alloc]init];
    NSMutableArray * recommendtitle = [[NSMutableArray alloc]init];
    //推荐视频ID
   NSMutableArray * recommendIDArr = [[NSMutableArray alloc]init];

    NSMutableArray * recommendima = [[NSMutableArray alloc]init];
    

    
    [[HttpClient shareInstance] requestApiWithurl:@"recommend"  parmar:params success:^(NSURLSessionDataTask *task, id response) {

        NSMutableDictionary * dic = [response objectForKey:@"result"];
        NSLog(@"推荐的视频的%@",dic);
        for (NSMutableDictionary * subDic in dic) {
            
            [recommendtitle addObject:subDic[@"name"]];
            [recommendIDArr addObject:subDic[@"id"]];
            [recommendima addObject:subDic[@"picture"]];
             
            
           
        }
        
        CGFloat margin = 20;
        CGFloat marginW = 10;
        CGFloat imaW = (kScreen_Width - margin * 2 - marginW * 2)/3;
        for (int i = 0; i<3; i++) {
            UIImageView * ima = [[UIImageView alloc]init];
            ima.frame = CGRectMake(margin + (marginW + imaW)* i, tuijian.y+22,imaW , tabHead.frame.size.height - tuijian.y - 40);

            NSString * str = [NSString stringWithFormat:@"%@",recommendima[i]];
            [ima sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:LoadImageByName(@"huodong_02")];
            ima.tag = [recommendIDArr[i] integerValue];
            [ima addTapTraget:self withAction:@selector(onPlayRecommend:)];
            [tabHead addSubview:ima];
            
            UILabel * titleLab = [[UILabel alloc]init];
            titleLab.frame = CGRectMake(ima.x, tabHead.frame.size.height - 20, imaW, 20);
            titleLab.text = recommendtitle[i];
            titleLab.textColor = [UIColor darkGrayColor];
            titleLab.font = font13;
            
            [tabHead addSubview:titleLab];
        }
        

         NSLog(@"推荐的视频为:%@",recommendTitleArr);
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"失败%@",response);
        
    }];

    
    
    [_tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommentTableViewCell"];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ActivityShowTableCell" bundle:nil] forCellReuseIdentifier:actCellIdent];
    [self.view addSubview:_tableView];
    
}
-(void)onPlayRecommend:(UITapGestureRecognizer *)tap{
    NSLog(@"点击推荐视频的ID为%ld",tap.view.tag);
    OutVideoPlayViewController * myVideo = [[OutVideoPlayViewController alloc]init];
    myVideo.videoID = [NSString stringWithFormat:@"%ld",tap.view.tag];
    [self.navigationController pushViewController:myVideo animated:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [myPlayer stop];
}

-(void)initVideo{
    if (!myPlayer) {
        myPlayer = [[ZXVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, kZXVideoPlayerOriginalWidth, kZXVideoPlayerOriginalHeight)];
        

        myPlayer.videoPlayerGoBackBlock = ^{
    
            
        [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"ZXVideoPlayer_DidLockScreen"];
            
            myPlayer = nil;
        };
        
        myPlayer.videoPlayerWillChangeToOriginalScreenModeBlock = ^(){
            NSLog(@"切换为竖屏模式");
            self.navigationController.navigationBarHidden = NO;
            _tableView.hidden = NO;
            introduceView.hidden = NO;
        };
        myPlayer.videoPlayerWillChangeToFullScreenModeBlock = ^(){
            NSLog(@"切换为全屏模式");
            self.navigationController.navigationBarHidden = YES;
            _tableView.hidden = YES;
            introduceView.hidden = YES;
        };
        
        [myPlayer showInView:self.view];
    }
    
    introduceView = [[UIView alloc]init];
    introduceView.frame = CGRectMake(0, kScreen_Height/3, kScreen_Width, 70);
    introduceView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:introduceView];
    
    UILabel * videoTitle = [[UILabel alloc]init];
    videoTitle.frame = CGRectMake(20, 10, kScreen_Width/2, 20);
    
    videoTitle.font = font15;
    [introduceView addSubview:videoTitle];
    
    UILabel * playCount = [[UILabel alloc]init];
    playCount.frame = CGRectMake(20, videoTitle.y+30, kScreen_Width/3, 20);
   
    playCount.font = font13;
    playCount.textColor = [UIColor darkGrayColor];
   // [introduceView addSubview:playCount];
    
    UIImageView * jifen = [[UIImageView alloc]init];
    jifen.frame = CGRectMake(kScreen_Width/6*4, 10, kScreen_Width/9, kScreen_Width/9);
    jifen.image = LoadImageByName(@"zhuanjifen_03");
    [jifen addTapTraget:self withAction:@selector(earnJifen)];
    [introduceView addSubview:jifen];
    
     gift = [[UIImageView alloc]init];
     gift.frame = CGRectMake(kScreen_Width/6*5, 10, kScreen_Width/12, kScreen_Width/12);
     [gift addTapTraget:self withAction:@selector(onShare)];
    gift.image = LoadImageByName(@"share_03");
    [introduceView addSubview:gift];
    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor = RGBColor(236, 236, 236);
    line.frame= CGRectMake(20, playCount.y+30, kScreen_Width-20, 1);
    [introduceView addSubview:line];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:@([@"1" intValue]) forKey:@"limit"];
    [params setValue:self.videoID  forKey:@"pid"];
    NSLog(@"该视频的ID%@",self.videoID);
    ZXVideo *video1 = [[ZXVideo alloc] init];
    
    
    [[HttpClient shareInstance] requestApiWithurl:@"video"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"成功%@",response);
        [FTShowMessageView dismiss];
   
        id  dic = [response objectForKey:@"result"];
        NSLog(@"播放视频的%@",dic);
        
        if (dic == [NSNull null]) {
            [HUD showAlertWithTitle:@"暂无数据"];
        }else{
            
            NSMutableDictionary * subdic = dic[1];
            videoTitle.text = subdic[@"name"];
            videoid =subdic[@"id"];
            self.navigationItem.title = videoTitle.text;
            NSString * url = [NSString stringWithFormat:@"%@",subdic[@"url"]];
            
             video1.playUrl  = [NSString stringWithFormat:@"%@%@",BaseVideoUrl,url];
            myPlayer.video = video1;

            NSString * vipUserType = [NSString stringWithFormat:@"%@",dic[0][@"vip"]];
            [UserInfo sharedUserInfo].vipType = vipUserType;
            [[UserInfo sharedUserInfo] saveUserInofFromSanbox];

            NSString * videoType = dic[1][@"state"];

           
                //开始播放
            [myPlayer play];
            
        }
        [self loadData];
        [self createUIWithvideoId:videoid];

       

    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"失败%@",response);
     
        [FTShowMessageView dismissErrorView:@"加载数据失败，请稍后重试"];
        
    }];
    

    
    

}
- (void)alertView:(CYAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSLog(@"点击确定了哦");
        BecomeMemberController * member = [[BecomeMemberController alloc]init];
        member.title = @"成为会员";
        [self.navigationController pushViewController:member animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)earnJifen{
    CustMyFormulateController * jifen = [[CustMyFormulateController alloc]init];
    jifen.isShowHeadView = YES;
    [self.navigationController pushViewController:jifen animated:YES];
}
-(void)sendGift{
    giftView = [[UIView alloc]init];
    giftView.frame = CGRectMake(0, kScreen_Height/3+70, kScreen_Width, kScreen_Height/3);
//    giftView.backgroundColor = [UIColor darkGrayColor];
//    giftView.alpha = 0.8;
   giftView.backgroundColor =   [[UIColor darkGrayColor] colorWithAlphaComponent:0.8];
    [self.view addSubview:giftView];
    NSMutableArray * imageArr =[[NSMutableArray alloc]initWithObjects:@"xin_03",@"tongbi_03",@"yinbi_03",@"jinbi_03",@"lvzuan_03",@"huangzuan_03",@"hongzuan_03",@"youting_03", nil];
    NSArray * imaNameArr = @[@"爱心",@"铜币",@"银币",@"金币",@"绿钻",@"黄钻",@"红钻",@"游艇"];
    NSArray * priceArr = @[@"免费",@"10金币",@"20金币",@"30金币",@"100金币",@"200金币",@"300金币",@"6000金币"];
    
    
    NSInteger count = 8;
    CGFloat margin = 30;
    CGFloat kwidth = kScreen_Width/8+10;
    CGFloat marginW = (kScreen_Width - margin * 2 - kwidth * 4)/3;

    for (NSInteger i =0; i<count; i++) {
        
        NSInteger rank = i/4;//行
        NSInteger column = i%4;//列
//        CGFloat KHfoot = kHeight/3;
        
        UIImageView * footIma =[[UIImageView alloc]init];
        footIma.tag = i+100;
        [footIma addTapTraget:self withAction:@selector(onClickGift:)];
        footIma.frame = CGRectMake( margin+(kwidth+marginW)*column, 10+(kwidth+marginW+10)*rank, kwidth, kwidth);
        footIma.image = LoadImageByName(imageArr[i]);
        [giftView addSubview:footIma];
        
        
        UILabel * imaNameLab = [[UILabel alloc]init];
        imaNameLab.frame =CGRectMake(footIma.x, footIma.y+kwidth, kwidth, 20);
        imaNameLab.textColor = [UIColor whiteColor];
        imaNameLab.font = font14;
        imaNameLab.text = imaNameArr[i];
        imaNameLab.textAlignment = NSTextAlignmentCenter;
        [giftView addSubview:imaNameLab];
        
        UILabel * priceLab = [[UILabel alloc]init];
        priceLab.frame = CGRectMake(footIma.x, imaNameLab.y+20, kwidth, 20);
        priceLab.textColor = [UIColor whiteColor];
        priceLab.font = font12;
        priceLab.textAlignment = NSTextAlignmentCenter;
        priceLab.text = priceArr[i];
        [giftView addSubview:priceLab];
        
    }

    
    giftView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    [gift addTapTraget:self withAction:@selector(hiddenGift)];
    [UIView animateWithDuration:1.0f animations:^{
        
        giftView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];

  
}
-(void)onClickGift:(UITapGestureRecognizer *)tap{
    switch (tap.view.tag) {
        case 100:
            [self heartClick];
            
            break;
        case 101:
            
            
            break;

        case 102:
            
            
            break;

        case 103:
            
            
            break;

        case 104:
            
            
            break;

        case 105:
            
            
            break;

        case 106:
            
            
            break;

        case 107:{
            selectedGift = [[UIImageView alloc]init];
            selectedGift.frame = CGRectMake(0, 20, 80, 50);
            selectedGift.image = LoadImageByName(@"youting_02_03");
            [myPlayer.view addSubview:selectedGift];
            
            [UIView animateWithDuration:2 animations:^{
                selectedGift.transform=CGAffineTransformTranslate(selectedGift.transform,kScreen_Width/4,50);
                selectedGift.transform = CGAffineTransformScale(selectedGift.transform, 2.0, 2.0);
                
                
            } completion:^(BOOL finished) {
             [selectedGift removeFromSuperview];

                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   
                    [UIView animateWithDuration:1.0 animations:^{
                        selectedGift.transform=CGAffineTransformTranslate(selectedGift.transform,kScreen_Width/4,100);
                        selectedGift.transform = CGAffineTransformScale(selectedGift.transform, 1.0, 1.0);

                        
                    }completion:^(BOOL finished) {
                        
                        [selectedGift removeFromSuperview];
                    }];
                    
                    
                    
                    
                    
                    
                });
                
               
                
                
            }];

            
            
            
            
        }
            
            
            break;

            
        default:
            break;
    }


}
-(void)hiddenGift{
    [giftView removeFromSuperview];
    [gift addTapTraget:self withAction:@selector(sendGift)];

}
//#pragma mark - xjAVPlayer代理
//- (void)nextXJPlayer{
////    myPlayer.xjPlayerUrl = @"http://www.jxgbwlxy.gov.cn/tm/course/041629011/sco1/1.mp4";
//    myPlayer.xjPlayerUrl = self.videoURL;
//}
//
//- (void)xjPlayerFullOrSmall:(BOOL)flag{
//    
//    //如果xjPlayer的界面有导航栏或者有tabbar,在全屏代理方法里全屏时进行如下隐藏；
//    if (flag) {
//        self.navigationController.navigationBarHidden = YES;
//        _tableView.hidden = YES;
//        introduceView.hidden = YES;
//
//    }else{
//        self.navigationController.navigationBarHidden = NO;
//        _tableView.hidden = NO;
//        introduceView.hidden = NO;
//       
//    }
//    
//    if (flag) {
//        /**
//         *  全屏时隐藏顶部状态栏。由于iOS7.0后，如果你的plist文件已经设置View controller-based status bar appearance，value设为NO，就不用写下面的代码（我已经封装好）,如果没设置，就把下面的代码放开，就能在全屏时隐藏头部状态栏；
//         */
//        //        [[UIApplication sharedApplication] setStatusBarHidden:YES];
//    }else{
//        //        [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    }
//}


#pragma mark - 加载数据
-(void)loadData{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
//    [params setValue:@([@"10" intValue]) forKey:@"limit"];
    [params setValue:@([self.videoID intValue]) forKey:@"pid"];
    
    [[HttpClient shareInstance] requestApiWithurl:@"comment"  parmar:params success:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"成功%@",response);
        [FTShowMessageView dismiss];
     

        id  dic = [response objectForKey:@"result"];
       NSLog(@"视频评论%@",dic);
        if (dic == [NSNull null]) {
            
        }
        else{
            for (NSMutableDictionary * subDic in dic) {
                commentModel * comment1 = [[commentModel alloc]init];
                comment1.icon = subDic[@"picture"];
                comment1.title = subDic[@"name"];
                comment1.date = subDic[@"time"];
                comment1.detail = subDic[@"content"];
                comment1.number = @"23";
                [self.souceArr addObject:comment1];
                [self.tableView reloadData];
                
            }
                   }
        
    } failuer:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"失败%@",response);
        [FTShowMessageView dismissErrorView:@"加载数据失败，请稍后重试"];
        
    }];
    

}
#pragma mark - tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return  self.souceArr.count ;
  
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
    CommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell" forIndexPath:indexPath];
    self.indexPath = indexPath;
    cell.delegate = self;
    [cell setContents:self.souceArr[indexPath.row]];
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    return cell;
    
    //    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return [CommentTableViewCell cellHeight:self.souceArr[indexPath.row ]];
    

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)pressZan:(NSString *)likeNum{
    NSLog(@"%@",likeNum);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 30;
   
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //    if (section == 1) {
    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
    headView.backgroundColor = [UIColor whiteColor];
    UILabel * headLab = [[UILabel alloc]init];
    headLab.frame = CGRectMake(10, 5, kScreen_Width/2, 20);
    if (self.souceArr.count == 0) {
        headLab.text = @"暂无评论"; 
    }else{
        headLab.text =[NSString stringWithFormat:@"全部评论  %ld",self.souceArr.count];
    }
    
    headLab.textColor = [UIColor blackColor];
    headLab.font = [UIFont systemFontOfSize:15];
    [headView addSubview:headLab];
    return headView;
    
}


@end
