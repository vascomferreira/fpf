//
//  ZonesMdl.m
//  FPF
//
//  Created by Vasco Ferreira on 5/24/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import "ZonesMdl.h"

@implementation ZonesMdl

@synthesize id, description, shortName;

- (ZonesMdl*) initWithDictionary: (NSDictionary*) dictionary
{
    self.id = [UTILS getInt:[dictionary objectForKey:@"ID"]];
    self.description = [dictionary objectForKey:@"Description"];
    self.shortName = [dictionary objectForKey:@"ShortName"];
    
    return self;
}

-(NSMutableDictionary *) toJSON {
    
    NSMutableDictionary *rawData = [NSMutableDictionary new];
    
//    [rawData setObject: [NSString stringWithFormat:@"%i",self.id] forKey:@"ID"];
//    
//    if( self.description != nil) [rawData setObject: self.description forKey:@"Description"];
//    else [rawData setObject: [NSNull null] forKey: @"Description"];
//    
//    if( self.shortName != nil) [rawData setObject: self.shortName forKey:@"ShortName"];
//    else [rawData setObject: [NSNull null] forKey: @"ShortName"];
    
    return rawData;
}


@end
