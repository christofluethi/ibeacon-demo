//
//  ViewController.m
//  iBeaconDemo
//
//  Created by Christof Luethi on 27.03.14.
//  Copyright (c) 2014 shaped.ch. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /* reachability related */
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(proximityNotificationReceived:)
                                                 name: kProximityNotification
                                               object: nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)proximityNotificationReceived:(NSNotification *) notification {
    if ([[notification name] isEqualToString:kProximityNotification]) {
        NSDictionary* userInfo = notification.userInfo;
        CLBeacon *nb = [userInfo objectForKey:@"iBeacon"];
        
        _nearestBeacon.text = [NSString stringWithFormat:@"Nearest Beacon Major[%@], Minor[%@]", nb.major, nb.minor];
    }
}

@end
