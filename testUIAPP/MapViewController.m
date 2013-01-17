//
//  MapViewController.m
//  
//
//  Created by Yong on 9-3-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "WebMapViewController.h"
//#import "CDataContainer.h"

@implementation MapViewController
@synthesize cityMapView,mapStyleSegCtr,mapNavigationBar;
@synthesize webMapViewController;
@synthesize points = _points;
@synthesize routeLine = _routeLine;
@synthesize routeLineView = _routeLineView;
@synthesize locationManager = _locationManager;
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)dealloc{
    [super dealloc];
	[cityMapView release];
	[mapStyleSegCtr release];
	[mapNavigationBar release];
	[webMapViewController release];
    [_routeLine release];
    [_points release];
    [_locationManager release];
    [_routeLineView release];
}

- (void)didReceiveMemoryWarning{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];
	UIBarButtonItem *webMapButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"WebMap"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(goToWebMap:)];
    self.navigationItem.rightBarButtonItem = webMapButton;
    [webMapButton release];
	CLLocationManager *locationMananger = [[CLLocationManager alloc] init];
	locationMananger.delegate = self;
	locationMananger.desiredAccuracy = kCLLocationAccuracyBest;
	locationMananger.distanceFilter = 1000.0;
	[locationMananger startUpdatingHeading];
	MKCoordinateSpan theSpan;
	theSpan.latitudeDelta = 0.05;
	theSpan.longitudeDelta = 0.05;
	MKCoordinateRegion theRegion;
	theRegion.center = [[locationMananger location]coordinate];
	theRegion.span = theSpan;
	[cityMapView setRegion:theRegion];
	[locationMananger release];
    
   
    
    // configure location manager
    [self configureLocationManger];
    
//    [self configureRoutes];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction) OnSegmentIndexChanged:(id)sender{
	if ([sender selectedSegmentIndex] == 0){
		NSLog(@"--------------OnSegmentIndexChanged1-------");
		
		cityMapView.mapType = MKMapTypeStandard;
	}
	else if([sender selectedSegmentIndex] == 1){
		NSLog(@"--------------OnSegmentIndexChanged2-------");
		
		cityMapView.mapType = MKMapTypeSatellite;
	}
	else if([sender selectedSegmentIndex] == 2){
		NSLog(@"--------------OnSegmentIndexChanged3-------");
		
		cityMapView.mapType = MKMapTypeHybrid;
	}
}

- (void)goToWebMap:(id)sender
{
	WebMapViewController *theController = [[[WebMapViewController alloc] initWithNibName:@"WebMapView" bundle:nil] autorelease];
	self.webMapViewController = theController;
	
//	[UIView beginAnimations:@"View Flip" context:nil];
//	[UIView setAnimationDuration:1.0];
//	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
//	[self.navigationController pushViewController:webMapViewController animated:YES];
//	[UIView commitAnimations];
    [self.view removeFromSuperview];
    
//    self.parentViewController.view = theController.view;

//    self.webMapViewController.view = theController.view;
    
//	[self.view removeFromSuperview];
    [self.view addSubview:theController.view];
//	[theController release];
    
//    [self.currentController.view  removeFromSuperview];
//    self.currentController = [_subViewControllers objectAtIndex:index];
//    [self.contentView addSubview:self.currentController.view];
    
}
- (IBAction)GotoMap:(id)sender {
    NSLog(@"gotomap.....");
    [self goToWebMap:sender];
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
	NSInteger styleNum = [userDefault integerForKey:@"styleType"];
	
	switch (styleNum) {
		case 0:{
			[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
			self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
			self.mapStyleSegCtr.tintColor = [UIColor colorWithRed:0.48	green:0.56 blue:0.66 alpha:1.0];
			self.mapNavigationBar.barStyle = UIBarStyleDefault;
			break;
		}
		case 1:{
			[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
			self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
			self.mapStyleSegCtr.tintColor = [UIColor darkGrayColor];
			self.mapNavigationBar.barStyle = UIBarStyleBlackOpaque;
			break;
		}
	}
}
- (void) configureRoutes
{
    MKMapPoint northEastPoint = MKMapPointMake(0.f, 0.f);
    MKMapPoint southWestPoint = MKMapPointMake(0.f, 0.f);
    MKMapPoint *pointArray = malloc(sizeof(CLLocationCoordinate2D)*_points.count);
    for (int idx = 0;  idx < _points.count; idx ++) {
        CLLocation *location = [_points objectAtIndex:idx];
        CLLocationDegrees latitude = location.coordinate.latitude;
        CLLocationDegrees longitude = location.coordinate.longitude;
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        MKMapPoint point = MKMapPointForCoordinate(coordinate);
        if (idx == 0) {
            northEastPoint = point;
            southWestPoint = point;
        }else{
            if (point.x > northEastPoint.x) {
                northEastPoint.x = point.x;
            }
            if (point.y > northEastPoint.y) {
                northEastPoint.y = point.y;
            }
            if (point.x < southWestPoint.x) {
                southWestPoint.x = point.x;
            }
            if (point.y < southWestPoint.y) {
                southWestPoint.y = point.y;
            }
        }
        pointArray[idx] = point;
    }
    if (self.routeLine) {
        [self.cityMapView removeOverlay:self.routeLine];
    }
    self.routeLine = [MKPolyline polylineWithPoints:pointArray count:_points.count];
    if (nil != self.routeLine) {
        [self.cityMapView addOverlay:self.routeLine];
    }
    free(pointArray);
}
//
#pragma mark --Location Manager
- (void) configureLocationManger
{
    if (nil == _locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    _locationManager.delegate  = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    _locationManager.distanceFilter = 50;
    [_locationManager startUpdatingLocation];
    [_locationManager startMonitoringSignificantLocationChanges];
}
#pragma mark CLLocationManager delegate methods
- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSDate *eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 2.0) {
        NSLog(@"recent: %g", abs(howRecent));        
        NSLog(@"latitude %+.6f, longitude %+.6f\n", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    }
}
- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@ ----- %@", self, NSStringFromSelector(_cmd));
    NSLog(@"error: %@",error);
}

//


#pragma mark MKMapViewDelegate
- (void) mapView:(MKMapView *)mapView didAddOverlayViews:(NSArray *)overlayViews
{
    NSLog(@"%@ ----- %@", self, NSStringFromSelector(_cmd));
    NSLog(@"overlayViews: %@", overlayViews);
}
- (MKOverlayView*)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    NSLog(@"%@ ----- %@", self, NSStringFromSelector(_cmd));
    
	MKOverlayView* overlayView = nil;
    if (overlay == self.routeLine) {
        if (self.routeLineView) {
            [self.routeLineView removeFromSuperview];
        }
        self.routeLineView = [[[MKPolylineView alloc] initWithPolyline:self.routeLine] autorelease];
        self.routeLineView.fillColor = [UIColor greenColor];
        self.routeLineView.strokeColor = [UIColor redColor];
        self.routeLineView.lineWidth = 5;
        overlayView = self.routeLineView;
    }
    return overlayView;
}
- (void) mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"%@ ----- %@", self, NSStringFromSelector(_cmd));
    NSLog(@"annotation views: %@", views);
}
- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"%@------%@",self,NSStringFromSelector(_cmd));
    CLLocation *location = [[[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude] autorelease];
    if (userLocation.coordinate.latitude == 0.0f || userLocation.coordinate.longitude == 0.0f) {
        return;
    }
    if (_points.count > 0) {
        CLLocationDistance distance = [location distanceFromLocation:_currentLocation];
        if (distance < 5) {
            return;
        }
    }
    if (nil == _points) {
        _points = [[NSMutableArray alloc] init];
    }
    [_points addObject:location];
    _currentLocation = location;
    NSLog(@"point %@",_points);
    
    [self configureRoutes];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    [self.cityMapView setCenterCoordinate:coordinate animated:YES];
    
}
- (void)viewDidUnload{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
