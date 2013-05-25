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
		[APP_DELEGATE addToPendingConnections:self];
		[self start];
	}
    
	return self;
}

-(NSString*) getURLRestWebService{
    return  [APP_DELEGATE getURLRestWebService];  //Producao
}


- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    NSArray* trustedHosts = @[@"cq-mcdo.grupocgd.com", @"m.caixadirecta.cgd.pt", @"cq-app.caixadirecta.cgd.pt", @"app.caixadirecta.cgd.pt", @"www.cgd.pt", @"cq-static.cgd.pt" , @"static.cgd.pt"];
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        if ([trustedHosts containsObject:challenge.protectionSpace.host])
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}


-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //NSLog(@"didReceiveResponse");
	[receivedData setLength:0];
    serviceResponse = response;
    
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //NSLog(@"didReceiveData");
	[receivedData appendData:data];
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection{
    //NSLog(@"connectionDidFinishLoading");
    [APP_DELEGATE removeFromPendingConnections:self];
    
	completeBlock(receivedData, serviceResponse);
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    //NSLog(@"didFailWithError");
    [APP_DELEGATE removeFromPendingConnections:self];
	errorBlock(error);
}

@end
