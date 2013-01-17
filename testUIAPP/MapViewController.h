//
//  MapViewController.h
// 
//
//  Created by yong on 9-3-12.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class WebMapViewController;

@interface MapViewController : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate>{
	MKMapView	*cityMapView;
	UINavigationBar	*mapNavigationBar;
	UISegmentedControl *mapStyleSegCtr;
	
	WebMapViewController *webMapViewController;
    NSMutableArray* _points;
    
	// the data representing the route points. 
	MKPolyline* _routeLine;
	
	// the view we create for the line on the map
	MKPolylineView* _routeLineView;
	
	// the rect that bounds the loaded points
	MKMapRect _routeRect;
    
    // location manager
    CLLocationManager* _locationManager;    
    
    // current location
    CLLocation* _currentLocation;
}


@property (nonatomic, retain) NSMutableArray* points;
@property (nonatomic, retain) MKPolyline* routeLine;
@property (nonatomic, retain) MKPolylineView* routeLineView;
@property (nonatomic, retain) CLLocationManager* locationManager;


@property (nonatomic, retain) IBOutlet MKMapView			*cityMapView;
@property (nonatomic, retain) IBOutlet UISegmentedControl	*mapStyleSegCtr;
@property (nonatomic, retain) IBOutlet UINavigationBar		*mapNavigationBar;

@property (nonatomic, retain) WebMapViewController		*webMapViewController;

- (IBAction) OnSegmentIndexChanged:(id)sender;

- (IBAction)GotoMap:(id)sender;
- (void) configureLocationManger;
- (void) configureRoutes;
@end
