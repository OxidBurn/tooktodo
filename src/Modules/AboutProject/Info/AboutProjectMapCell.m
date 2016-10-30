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
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
    NSLog(@"error %@",  error.localizedDescription);
}


@end
