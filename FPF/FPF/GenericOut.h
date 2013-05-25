//
//  GenericOut.h
//  FPF
//
//  Created by Vasco Ferreira on 5/25/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericModel.h"

@interface GenericOut : NSObject

@property (nonatomic) GenericModelState responseState;
@property (nonatomic,strong) NSString *serverErrorMessage;
@property (nonatomic,strong) NSDictionary *credentialData;

- (id)initWithData:(NSData *)data ;

- (id)initWithJSON:(NSDictionary *)jsonInfo ;

- (id)initWithGenericModel:(GenericModel *)serverResponse ;

-(BOOL) isValidServerResponse;

@end
