//
//  BeaconManager.m
//  iBeaconDemo
//
//  Created by Christof Luethi on 27.03.14.
//  Copyright (c) 2014 shaped.ch. All rights reserved.
//

#import "BeaconManager.h"

@implementation BeaconManager

/* yes this is a singleton */
+ (id)sharedInstance {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

-(id)init {
    self = [super init];
    
    if(self) {
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
        [self setRunning:NO];
    }
    
    return self;
}

-(void)restart {
    if([self isRunning]) {
        [self stop];
    }
    
    DLog("Restarting BeaconManager...");
    
    [self startBeaconMonitoring];
    [self setRunning:YES];
}

-(void)start {
    [self restart];
}

-(void)stop {
    [self stopBeaconMonitoring];
    [self setRunning:NO];
}

-(void)startBeaconMonitoring {
    // create sample region with major value defined
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:kUUID];
    
    _beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:kBeaconRegion];
    _beaconRegion.notifyEntryStateOnDisplay = YES;
    
    [_locationManager startMonitoringForRegion:_beaconRegion];
    DLog("Start monitoring Region: %@", kUUID);
    
    [_locationManager startRangingBeaconsInRegion:_beaconRegion];
    DLog("Start ranging iBeacons for region: %@", kUUID);
}

-(void)stopBeaconMonitoring {
    [_locationManager stopRangingBeaconsInRegion:_beaconRegion];
    
    [self setRunning:NO];
    DLog("Stop monitoring for region %@", kUUID);
}

-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    if([beacons count] > 0) {
        
        // beacon array is sorted based on distance
        // closest beacon is the first one
        CLBeacon* ne = [beacons objectAtIndex:0];
        
        if(_nearestExhibit == nil || _nearestExhibit.major != ne.major || _nearestExhibit.minor != ne.minor) {
            /* nearestbeacon changed */
            _nearestExhibit = ne;
            DLog("Nearest beacon changed");
            
            if(CLProximityNear == _nearestExhibit.proximity || CLProximityImmediate == _nearestExhibit.proximity) {
                /* nearest beacon is NEAR or IMMEDIATE */
                    DLog("Firing ProximityNotification");
                    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
                    [userInfo setObject:_nearestExhibit forKey:@"iBeacon"];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kProximityNotification object:self userInfo:userInfo];
                
                // present local notification
                UILocalNotification *notification = [[UILocalNotification alloc] init];
                notification.alertBody = [NSString stringWithFormat:@"Hey, you're near beacon Major[%@], Minor[%@]", _nearestExhibit.major, _nearestExhibit.minor];
                notification.soundName = UILocalNotificationDefaultSoundName;
                
                [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
            } else {
                /* no near beacons available */
            }
        }
    } else {
        DLog("NO iBeacons available");
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    DLog("Entered Region");
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = @"Enter region notification";
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    DLog("Exited Region");
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = @"Exited region notification";
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}


@end
