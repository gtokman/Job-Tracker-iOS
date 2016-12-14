//
//  CheckNetwork.m
//  After College Job Tracker
//
//  Created by g tokman on 12/14/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

#import "CheckNetwork.h"

@implementation CheckNetwork


+(bool) hasNetworkConnection {
    
    SCNetworkReachabilityFlags flags;
    SCNetworkReachabilityRef ref;
    
    ref = SCNetworkReachabilityCreateWithName(NULL, "www.google.com");
    
    Boolean isConnected = SCNetworkReachabilityGetFlags(ref, &flags);
    
    CFRelease(ref);
    
    return isConnected && !(flags & kSCNetworkReachabilityFlagsConnectionRequired)
    && (flags & kSCNetworkReachabilityFlagsReachable);
}

@end
