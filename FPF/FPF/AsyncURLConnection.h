//
//  AsyncURLConnection.h
//  FPF
//
//  Created by Vasco Ferreira on 5/25/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^completeBlock_t)(NSData* data, NSURLResponse* response);
typedef void (^errorBlock_t)(NSError *error);

typedef enum{
    RTDEFAULT,
    RTBASICAUTH,
    RTMATRIZ,
    RTNIF,
    RTSMS,
    RTPIN,
    RTFILE,
    RTLOGOUT
}RequestType;

@interface AsyncURLConnection : NSURLConnection{
	NSMutableData *receivedData;
    NSURLResponse *serviceResponse;
	completeBlock_t completeBlock;
	errorBlock_t errorBlock;
}

+(id) request:(NSString *)requestUrl jsonRequest:(NSString*)jsonReq completeBlock:(completeBlock_t)_completeBlock errorBlock:(errorBlock_t)_errorBlock;

-(id) initWithRequest:(NSString *)requestUrl jsonRequest:(NSString*)jsonReq completeBlock:(completeBlock_t)_completeBlock errorBlock:(errorBlock_t)_errorBlock;

@end
