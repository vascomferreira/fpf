//
//  GenericBinaryOut.m
//  FPF
//
//  Created by Vasco Ferreira on 5/25/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import "GenericBinaryOut.h"

@implementation GenericBinaryOut

- (id)initWithData:(NSData *)data {
    
    
    self = [super init];
    
    if ( self ) {
        
        self.binPackage = data;
    }
    return self;
}

@end
