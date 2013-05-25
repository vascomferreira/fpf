//
//  FPFServices.h
//  FPF
//
//  Created by Vasco Ferreira on 5/25/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASyncURLConnection.h"
#import "JSONKit.h"

@class GenericModel;
@interface FPFServices : NSObject

+(void) callService:(NSString*)url withData:(NSString*)jsonRequest withReqType:(RequestType)rt authObj:(id)authObj completed:(void (^)(GenericModel*))completed;

+(GenericModel *) handleResponse:(NSURLResponse *)response withData:(NSData*)data;

+(GenericModel *) handleException:(NSException *)exc;

+(BOOL) handleState:(GenericModel *)model;

+(void) clearConnSessionData;

@end
