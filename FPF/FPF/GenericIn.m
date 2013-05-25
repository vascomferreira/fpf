//
//  GenericIn.m
//  FPF
//
//  Created by Vasco Ferreira on 5/24/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import "GenericIn.h"
#import "JSONKit.h"

@implementation GenericIn

-(NSMutableDictionary *) toJSON {
    
    return [NSMutableDictionary dictionary];
    
}
-(NSString *) toJSONString {
    return [[self toJSON] JSONString];
}

@end
