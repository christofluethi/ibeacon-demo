//
//  Constants.h
//  iBeaconDemo
//
//  Created by Christof Luethi on 27.03.14.
//  Copyright (c) 2014 shaped.ch. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
    #define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
    #define DLog(...)
#endif

extern NSString *const kUUID;
extern NSString *const kBeaconRegion;

// Notifications
extern NSString *const kProximityNotification;

@interface Constants : NSObject

@end
