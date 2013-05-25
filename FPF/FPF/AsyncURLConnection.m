//
//  AsyncURLConnection.m
//  FPF
//
//  Created by Vasco Ferreira on 5/25/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import "AsyncURLConnection.h"

@implementation AsyncURLConnection

+(id) request:(NSString *)requestUrl jsonRequest:(NSString*)jsonReq completeBlock:(completeBlock_t)_completeBlock errorBlock:(errorBlock_t)_errorBlock{
	return [[self alloc] initWithRequest:requestUrl jsonRequest:jsonReq completeBlock:_completeBlock errorBlock:_errorBlock];
}


-(id) initWithRequest:(NSString *)requestUrl jsonRequest:(NSString*)jsonReq completeBlock:(completeBlock_t)_completeBlock errorBlock:(errorBlock_t)_errorBlock {
    
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[self getURLRestWebService],requestUrl]];
    
    //Logging output for debugging purposes
    if(UNDER_DEVELOPMENT){
        NSString* jSessionCookieValue;
        NSHTTPCookieStorage * cookiesStor = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        BOOL findCookie = NO;
        for (NSHTTPCookie *cookie in [cookiesStor cookies]){
            if([[cookie name] isEqualToString:@"JSESSIONID"]){
                findCookie = TRUE;
                jSessionCookieValue = cookie.value;
            }
        }
        if(!findCookie){
            jSessionCookieValue = @"<not found>";
        }
        
        NSLog(@"Request Type: %@", (jsonReq == nil? @"GET" : @"POST"));
        NSLog(@"Request URL: %@", url);
        NSLog(@"Request JSESSIONID (%@): %@", @"Not Authenticated", jSessionCookieValue);
        if(jsonReq != nil){
            NSLog(@"Request JSON:");
            NSLog(@"%@", jsonReq);
        }
    }
    
	NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    
     
    if(jsonReq != nil){
        [req setHTTPMethod:@"POST"];
        [req addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [req setHTTPBody: [jsonReq dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    req.timeoutInterval = 120;
    
    
	if ((self = [super initWithRequest:req delegate:self startImmediately:NO])) {
		receivedData = [NSMutableData new];
        
		completeBlock = _completeBlock;
		errorBlock = _errorBlock;
		[self start];
	}
    
	return self;
}


-(NSString*) getURLRestWebService{
    return  [APP_DELEGATE getURLRestWebService];  //Producao
}

@end
