//
//  UIAViewController.m
//  UIA
//
//  Created by Yong on 12-10-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIAViewController.h"

#import "ForeignNewTableViewController.h"
#import "EnterTainmentNewsTableViewController.h"
#import "SportNewsTableView.h"
#import "NewsViewController.h"
#import "ChinaNewsTableView.h"
//#import "WiAdView.h"
#import"myimgeview.h"

#define RADIUS 120.0
#define PHOTONUM 5
#define PHOTOSTRING @"icons"
#define TAGSTART 1000
#define TIME 1.5
#define SCALENUMBER 1.25
int array [PHOTONUM][PHOTONUM] ={
	{0,1,2,3,4},
	{4,0,1,2,3},
	{3,4,0,1,2},
	{2,3,4,0,1},
	{1,2,3,4,0}
};
@implementation UIAViewController

@synthesize currentController;
@synthesize delegate,currenttag;
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
CATransform3D rotationTransform1[PHOTONUM];
- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	self.view.backgroundColor = [UIColor clearColor];
	UIImageView *backview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"newsBackGround.png"]];
	backview.frame = self.view.frame;
	backview.center = CGPointMake(backview.center.x, backview.center.y);
	
	backview.alpha = 0.3;
	[self.view addSubview:backview];
	
    NSArray *textArray = [NSArray arrayWithObjects:@"头条",@"国外",@"娱乐",@"体育",@"国内",nil];
    
	float centery = self.view.center.y - 50;
	float centerx = self.view.center.x;
    
	for (int i = 0;i<PHOTONUM;i++ ) 
	{
		float tmpy =  centery + RADIUS*cos(2.0*M_PI *i/PHOTONUM);
		float tmpx =	centerx - RADIUS*sin(2.0*M_PI *i/PHOTONUM);
		myimgeview *addview1 =	[[myimgeview alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%d",PHOTOSTRING,i]] text:[textArray objectAtIndex:i]];
        addview1.frame = CGRectMake(0.0, 0.0,120,140);
		[addview1 setdege:self];
		addview1.tag = TAGSTART + i;
		addview1.center = CGPointMake(tmpx,tmpy);
		rotationTransform1[i] = CATransform3DIdentity;	
		
		//float Scalenumber =atan2f(sin(2.0*M_PI *i/PHOTONUM));
		float Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
		if (Scalenumber<0.3) 
		{
			Scalenumber = 0.4;
		}
		CATransform3D rotationTransform = CATransform3DIdentity;
		rotationTransform = CATransform3DScale (rotationTransform, Scalenumber*SCALENUMBER,Scalenumber*SCALENUMBER, 1);		
		addview1.layer.transform=rotationTransform;		
		[self.view addSubview:addview1];
		
	}
	self.currenttag = TAGSTART;
	//[self.view addSubview:addview];	
	//[self.view.layer.];
	//[addview release];
	
	//[self performSelector:@selector(Scale) withObject:nil afterDelay:1];
    
#if 0
    WiAdView* adView = [WiAdView adViewWithResId:@"4844096a1364e610" style:kWiAdViewStyleBanner320_50];
    adView.center = CGPointMake(160.0,25.0);
    adView.delegate = self;
    adView.refreshInterval = 31;
    adView.adBgColor = [UIColor colorWithRed:1.0f green:(CGFloat)0x66/255 blue:(CGFloat)0x33/255 alpha:1.0f];
    [self.view addSubview:adView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"request-close.png"]];
    [self.view addSubview:imageView];
    imageView.center = CGPointMake(310,adView.center.y);
    
    [adView requestAd];
    /*
    adView = [WiAdView adViewWithResId:@"4844096a1364e610" style:kWiAdViewStyleBanner320_50];
    adView.center = CGPointMake(160,75);
    adView.delegate = self;
    adView.refreshInterval = 31;
    adView.adBgColor = [UIColor colorWithRed:1.0f green:(CGFloat)0x66/255 blue:(CGFloat)0x33/255 alpha:1.0f];
    [self.view addSubview:adView];
    [adView requestAd];
    */
    adView = [WiAdView adViewWithResId:@"4844096a1364e610" style:kWiAdViewStyleBanner320_50];
    adView.center = CGPointMake(160,435);
    adView.delegate = self;
    adView.refreshInterval = 31;
    adView.adBgColor = [UIColor colorWithRed:1.0f green:(CGFloat)0x66/255 blue:(CGFloat)0x33/255 alpha:1.0f];
    [self.view addSubview:adView];
    imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"request-close.png"]];
    [self.view addSubview:imageView];
    imageView.center = CGPointMake(310,adView.center.y);
    
    [adView requestAd];
#endif

}
-(CAAnimation*)setscale:(NSInteger)tag clicktag:(NSInteger)clicktag
{
	
	
	int i = array[clicktag - TAGSTART][tag - TAGSTART];
	int i1 = array[currenttag - TAGSTART][tag - TAGSTART];
	float Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
	float Scalenumber1 = fabs(i1 - PHOTONUM/2.0)/(PHOTONUM/2.0);
	if (Scalenumber<0.3) 
	{
		Scalenumber = 0.4;
	}
	UIImageView *imgview = (UIImageView*)[self.view viewWithTag:tag];
	CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
	animation.duration = TIME;
	animation.repeatCount =1;
	
	
    CATransform3D dtmp = CATransform3DScale(rotationTransform1[tag - TAGSTART],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
	animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(rotationTransform1[tag - TAGSTART],Scalenumber1*SCALENUMBER,Scalenumber1*SCALENUMBER, 1.0)];
	animation.toValue = [NSValue valueWithCATransform3D:dtmp ];
	animation.autoreverses = NO;	
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeForwards;
	//
    imgview.layer.transform=dtmp;
	
	return animation;
}

-(void)Clickup:(NSInteger)tag
{
//    kIsAdShow;
	NSLog(@"点击TAG%d:",tag);
    NSLog(@"self.currnet.view %@",self.currentController.view.frame);
//     [delegate setMainTitleWithDelegate:self];
    
    if (self.currenttag == tag && self.currenttag == 1000) {
        [self.currentController.view removeFromSuperview];
        NewsViewController *top = [[NewsViewController alloc] initWithNibName:@"NewsViewController_More" bundle:nil];
        self.currentController = top;
        [self.view addSubview:self.currentController.view];
        [top release];
        [delegate setMainTitleWithDelegate:self];

        return;
    }
    if (self.currenttag == tag && tag == 1001) {
        NSLog(@"push....");
        [self.currentController.view removeFromSuperview];
        ForeignNewTableViewController *fore = [[ForeignNewTableViewController alloc] initWithNibName:@"ForeignNewTableViewController" bundle:nil];
        self.currentController  = fore;
        [self.view addSubview:self.currentController.view];
        [delegate setMainTitleWithDelegate:self];
        [fore release];
        return;
    }
    if (self.currenttag == tag && self.currenttag == 1002) {
        [self.currentController.view removeFromSuperview];
        EnterTainmentNewsTableViewController *entery = [[EnterTainmentNewsTableViewController alloc] initWithNibName:@"EnterTainmentNewsTableViewController" bundle:nil];
        self.currentController = entery;
        [self.view addSubview:self.currentController.view];
        [entery release];
        [delegate setMainTitleWithDelegate:self];
        return;
    }
    if (self.currenttag == tag && self.currenttag == 1003) {
        [self.currentController.view removeFromSuperview];
        SportNewsTableView *sport = [[SportNewsTableView alloc] initWithNibName:@"SportNewsTableView" bundle:nil];
        self.currentController = sport;
        [self.view addSubview:self.currentController.view];
        [sport release];
        [delegate setMainTitleWithDelegate:self];
        return;
    }
   
    if (self.currenttag == tag && self.currenttag == 1004) {
        [self.currentController.view removeFromSuperview];
        ChinaNewsTableView *china = [[ChinaNewsTableView alloc] initWithNibName:@"ChinaNewsTableView" bundle:nil];
        self.currentController = china;
        [self.view addSubview:self.currentController.view];
        [china release];
        [delegate setMainTitleWithDelegate:self];
        return;
    }
	if(self.currenttag == tag)
	{
		UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"点击" message: @"添加对应的处理" delegate:nil  cancelButtonTitle:@"OK" otherButtonTitles:nil];
		av.tag=110;
		[av show];
		[av release];	
		return;
	}
	int t = [self getblank:tag];
	//NSLog(@"%d",t);
	int i = 0;
	for (i = 0;i<PHOTONUM;i++ ) 
	{
		
		UIImageView *imgview = (UIImageView*)[self.view viewWithTag:TAGSTART+i];
		[imgview.layer addAnimation:[self moveanimation:TAGSTART+i number:t] forKey:@"position"];
		[imgview.layer addAnimation:[self setscale:TAGSTART+i clicktag:tag] forKey:@"transform"];
		
		int j = array[tag - TAGSTART][i];
		float Scalenumber = fabs(j - PHOTONUM/2.0)/(PHOTONUM/2.0);
		if (Scalenumber<0.3) 
		{
			Scalenumber = 0.4;
		}
//        
		CATransform3D dtmp = CATransform3DScale(rotationTransform1[i],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
		imgview.layer.transform=dtmp;
		
	//	imgview.layer.needsDisplayOnBoundsChange = YES;
	}
	self.currenttag = tag;
//	[self performSelector:@selector(setcurrenttag) withObject:nil afterDelay:TIME];
}
-(void)setcurrenttag
{
	int i = 0;
	for (i = 0;i<PHOTONUM;i++ ) 
	{
		
		UIImageView *imgview = (UIImageView*)[self.view viewWithTag:TAGSTART+i];		
		int j = array[self.currenttag - TAGSTART][i];
		float Scalenumber = fabs(j - PHOTONUM/2.0)/(PHOTONUM/2.0);
		if (Scalenumber<0.3) 
		{
			Scalenumber = 0.4;
		}
		CATransform3D dtmp = CATransform3DScale(rotationTransform1[i],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
		imgview.layer.transform=dtmp;
		
		//	imgview.layer.needsDisplayOnBoundsChange = YES;
	}
}


-(CAAnimation*)moveanimation:(NSInteger)tag number:(NSInteger)num
{
	// CALayer
	UIImageView *imgview = (UIImageView*)[self.view viewWithTag:tag];
    CAKeyframeAnimation* animation;
    animation = [CAKeyframeAnimation animation];	
	CGMutablePathRef path = CGPathCreateMutable();
	NSLog(@"原点%f原点%f",imgview.layer.position.x,imgview.layer.position.y);
	CGPathMoveToPoint(path, NULL,imgview.layer.position.x,imgview.layer.position.y);
	
	int p =  [self getblank:tag];
	NSLog(@"旋转%d",p);
	float f = 2.0*M_PI  - 2.0*M_PI *p/PHOTONUM;
	float h = f + 2.0*M_PI *num/PHOTONUM;
	float centery = self.view.center.y - 50;
	float centerx = self.view.center.x;
	float tmpy =  centery + RADIUS*cos(h);
	float tmpx =	centerx - RADIUS*sin(h);
	imgview.center = CGPointMake(tmpx,tmpy);
	
	CGPathAddArc(path,nil,self.view.center.x, self.view.center.y - 50,RADIUS,f+ M_PI/2,f+ M_PI/2 + 2.0*M_PI *num/PHOTONUM,0);	
	animation.path = path;
	CGPathRelease(path);
	animation.duration = TIME;
	animation.repeatCount = 1;
 	animation.calculationMode = @"paced"; 	
	return animation;
}


-(NSInteger)getblank:(NSInteger)tag
{
	if (self.currenttag>tag) 
	{
		return self.currenttag - tag;
	}
	else 
	{
		return PHOTONUM  - tag + self.currenttag;
	}

}

-(void)Scale
{
	[UIView beginAnimations:nil context:self];
	[UIView setAnimationRepeatCount:3];
    [UIView setAnimationDuration:1];	
	
	/*
	 + (void)setAnimationWillStartSelector:(SEL)selector;                // default = NULL. -animationWillStart:(NSString *)animationID context:(void *)context
	 + (void)setAnimationDidStopSelector:(SEL)selector;                  // default = NULL. -animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
	 + (void)setAnimationDuration:(NSTimeInterval)duration;              // default = 0.2
	 + (void)setAnimationDelay:(NSTimeInterval)delay;                    // default = 0.0
	 + (void)setAnimationStartDate:(NSDate *)startDate;                  // default = now ([NSDate date])
	 + (void)setAnimationCurve:(UIViewAnimationCurve)curve;              // default = UIViewAnimationCurveEaseInOut
	 + (void)setAnimationRepeatCount:(float)repeatCount;                 // default = 0.0.  May be fractional
	 + (void)setAnimationRepeatAutoreverses:(BOOL)repeatAutoreverses;
	 */
	
	CATransform3D rotationTransform = CATransform3DIdentity;

    rotationTransform = CATransform3DRotate(rotationTransform,3.14, 1.0, 0.0, 0.0);	
	//rotationTransform = CATransform3DScale (rotationTransform, 0.1,0.1, 2);
    //self.view.transform=CGAffineTransformMakeScale(2,2);
	
	self.view.layer.transform=rotationTransform;
    [UIView setAnimationDelegate:self];	
    [UIView commitAnimations];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [currentController release];


    [super dealloc];
}

@end
