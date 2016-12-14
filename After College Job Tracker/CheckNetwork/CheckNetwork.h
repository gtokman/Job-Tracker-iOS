//
//  CheckNetwork.h
//  After College Job Tracker
//
//  Created by g tokman on 12/14/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

@interface CheckNetwork : NSObject

+(bool) hasNetworkConnection;

@end
