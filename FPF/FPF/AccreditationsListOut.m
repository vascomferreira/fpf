//
//  AccreditationsListOut.m
//  FPF
//
//  Created by Vasco Ferreira on 5/25/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import "AccreditationsListOut.h"
#import "AccreditationMdl.h"

@implementation AccreditationsListOut

-(id)initWithJSON:(NSDictionary *)jsonInfo {
    self = [super init];
    
    if (self) {
        self.accreditationsList = [NSMutableArray new];
        for(NSDictionary *innerDic in [jsonInfo objectForKey:@"ListOfItems"]){
            [self.accreditationsList addObject: [[AccreditationMdl alloc] initWithDictionary:innerDic]];
        }
    }
    
    return self;
}


@end
