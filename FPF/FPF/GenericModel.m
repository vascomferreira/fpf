//
//  GenericModel.m
//  FPF
//
//  Created by Vasco Ferreira on 5/25/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import "GenericModel.h"

@implementation GenericModel

@synthesize data, msg, state;

-(id) init{
    
    if ((self = [super init])){
        
        data = nil;
        msg = nil;
    }
    return self;
}

-(id) initWithData:(id)_data withMsg:(NSString*)_msg withState:(GenericModelState) gms{
    
    if ((self = [super init])){
        
        
        data = _data;
        msg = _msg;
        state = gms;
    }
    return self;
}


@end
