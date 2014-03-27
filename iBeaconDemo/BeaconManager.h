//
//  BeaconManager.h
//  iBeaconDemo
//
//  Created by Christof Luethi on 27.03.14.
//  Copyright (c) 2014 shaped.ch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface BeaconManager : NSObject<CLLocationManagerDelegate>
+(id)sharedInstance;
-(void)start;
-(void)stop;
-(void)restart;

@property (nonatomic, assign, getter=isRunning) BOOL running;
@property (nonatomic, strong) CLBeaconRegion *beaconRegion;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLBeacon *nearestExhibit;

@end
