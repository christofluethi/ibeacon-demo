//
//  ViewController.h
//  iBeaconDemo
//
//  Created by Christof Luethi on 27.03.14.
//  Copyright (c) 2014 shaped.ch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nearestBeacon;

@end
