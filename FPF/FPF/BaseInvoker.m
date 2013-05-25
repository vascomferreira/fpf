//
//  BaseInvoker.m
//  FPF
//
//  Created by Vasco Ferreira on 5/24/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import "BaseInvoker.h"
#import "GenericIn.h"
#import "AsyncURLConnection.h"
#import "FPFServices.h"

@implementation BaseInvoker

//para servicos POST que têm como input um Objecto e nao uma serie de campos
+(void) executeServiceAtUrlWithParameters:(NSString *)url  serviceInput:(GenericIn *)input completed:(void (^)(GenericModel *))completed {
    NSString *reqURL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *inputJSONString=[input toJSONString];
    
    [AsyncURLConnection request:reqURL jsonRequest:inputJSONString completeBlock:^(NSData* data, NSURLResponse* response){
        
        if(UNDER_DEVELOPMENT){
            NSString* s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse*)response;
            NSLog(@"Response (CODE %i) body:", [httpResponse statusCode] );
            NSLog(@"%@", s);
        }
        
        GenericModel *result;
        
        @try{
            
            result = [FPFServices handleResponse:response withData:data];
            
        }@catch(NSException *exc){
            
            result = [FPFServices handleException:exc];
        }
        
        if([FPFServices handleState:result] && completed)
            completed(result);

        
        
    }errorBlock:^(NSError *error){
        
        [self handleError:error andReturn:completed];
        
    }];
    
}

+(void) handleError:(NSError*)error andReturn:(void (^)(GenericModel *))completed {
    //handle offline, etc....!!!!!!!!
    GenericModel *resultError = [[GenericModel alloc] initWithData:nil withMsg:@"Erro na ligação" withState:GMSFailure];
    completed(resultError);
    NSLog(@"error: %@",error);
}

@end
