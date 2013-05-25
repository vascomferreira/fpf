//
//  GetAccreditationsIn.m
//  FPF
//
//  Created by Vasco Ferreira on 5/24/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import "AccreditationsListIn.h"

@implementation AccreditationsListIn

@synthesize eventID, token;

-(NSMutableDictionary *) toJSON {
    NSMutableDictionary *rawData = [super toJSON];
    
    [rawData setObject: [NSString stringWithFormat:@"%i",self.eventID] forKey:@"eventID"];
    
    if ( self.token != nil ) [rawData setObject: self.token forKey:@"token"];
    else [rawData setObject:[NSNull null] forKey:@"token"];
    
    return rawData;
}

@end
