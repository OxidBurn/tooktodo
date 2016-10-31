//
//  AboutProjectMapCell.m
//  TookTODO
//
//  Created by Глеб on 28.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AboutProjectMapCell.h"

// Frameworks
@import MapKit;

@interface AboutProjectMapCell() <MKMapViewDelegate>

// outlets
@property (weak, nonatomic) IBOutlet MKMapView* aboutProjectMapView;

@property (weak, nonatomic) IBOutlet UILabel*   titleLabel;

@property (weak, nonatomic) IBOutlet UIView*    detailLabel;

// properties


// methods


@end

@implementation AboutProjectMapCell

#pragma mark - Public -

- (void) fillCellWithTitle: (NSString*) title
           withCoordinates: (NSString*) coordinates
{
    self.titleLabel.text      = title;
    
    self.detailTextLabel.text = coordinates;
    
    self.aboutProjectMapView.delegate = self;
    
    self.aboutProjectMapView.mapType     = MKMapTypeHybrid;
    self.aboutProjectMapView.zoomEnabled = NO;
    self.aboutProjectMapView.mapType = MKMapTypeStandard;
    self.aboutProjectMapView.showsUserLocation = YES;
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
    NSLog(@"error %@",  error.localizedDescription);
}

- (IBAction)setMapType:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.aboutProjectMapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.aboutProjectMapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            self.aboutProjectMapView.mapType = MKMapTypeHybrid;
            break;
        default:
            break;
    }
}

- (IBAction)zoomToCurrentLocation:(UIBarButtonItem *)sender {
    float spanX = 0.00725;
    float spanY = 0.00725;
    MKCoordinateRegion region;
    region.center.latitude = self.aboutProjectMapView.userLocation.coordinate.latitude;
    region.center.longitude = self.aboutProjectMapView.userLocation.coordinate.longitude;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    [self.aboutProjectMapView setRegion:region animated:YES];
}


-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    [self.aboutProjectMapView setCenterCoordinate:userLocation.coordinate animated:YES];
}

@end
