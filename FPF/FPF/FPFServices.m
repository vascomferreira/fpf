//
//  FPFServices.m
//  FPF
//
//  Created by Vasco Ferreira on 5/25/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import "FPFServices.h"
#import "GenericModel.h"

@implementation FPFServices

+(void) callService:(NSString*)url withData:(NSString*)jsonRequest withReqType:(RequestType)rt authObj:(id)authObj completed:(void (^)(GenericModel*))completed{
    
    NSString *reqURL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AsyncURLConnection *conn= [AsyncURLConnection request:reqURL jsonRequest:jsonRequest completeBlock:^(NSData* data, NSURLResponse* response){
        
        if(UNDER_DEVELOPMENT){
            NSString* s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse*)response;
            NSLog(@"Response (CODE %i) body:", [httpResponse statusCode] );
            NSLog(@"%@", s);
        }
        
        GenericModel *result;
        
        @try{
            result = [self handleResponse:response withData:data];
        }@catch(NSException *exc){
            result = [self handleException:exc];
        }
        if([self handleState:result] && completed)
            completed(result);
        
    }errorBlock:^(NSError *error){
        //todo:
        //handle offline, timeout, etc....!!!!!!!!
        GenericModel *resultError = [[GenericModel alloc] initWithData:nil withMsg:@"Erro na ligação" withState:GMSFailure];
        completed(resultError);
        NSLog(@"error: %@",error);
    }];
    
    [APP_DELEGATE addToPendingConnections:conn];
}

+(GenericModel *) handleResponse:(NSURLResponse *)response withData:(NSData*)data{
    
    
    GenericModel *result = [GenericModel new];
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    NSDictionary* resultData;
    if(data != nil && [[httpResponse.allHeaderFields objectForKey:@"Content-Type"] isEqualToString:@"application/json"]){
        resultData = [data objectFromJSONData];
    }
    
    if(httpResponse.statusCode == 200){     //OK
        result.data =  data;
        result.msg = @"";
        result.state = GMSSuccess;
        return result;
    }
    
    NSString *msg = resultData ? [resultData objectForKey:@"m"] : @"";
    if([msg isEqualToString:@""])
        msg = @"Erro genérico";
    NSString *type = resultData ? [resultData objectForKey:@"t"] : @"";
    
    if(httpResponse.statusCode == 401){   //Unauthorized
        
        NSString* authTypeH = [httpResponse.allHeaderFields objectForKey:@"WWW-Authenticate"];
        NSException *excp;
        
        if(![authTypeH isEqual:[NSNull null]]){
            
            NSArray* comp = [authTypeH componentsSeparatedByString:@" "];
            NSString* authType = [comp objectAtIndex:0];
            
            if([authType isEqualToString:@"Basic"]){
                
                NSDictionary *excpValues = [NSDictionary dictionaryWithObject:msg forKey:@"message"];
                excp = [NSException exceptionWithName:@"ContratoPin" reason:@"Autenticacao" userInfo:excpValues];
                
            }else if([authType isEqualToString:@"CHANGE_PIN"]){
                
                NSDictionary *excpValues = [NSDictionary dictionaryWithObject:msg forKey:@"message"];
                excp = [NSException exceptionWithName:@"MudarPin" reason:@"Autenticacao" userInfo:excpValues];
                
            }else if([authType isEqualToString:@"MATRIX"]){
                
                NSString *coords = [comp objectAtIndex:1];
                NSArray *coordsA = [coords componentsSeparatedByString:@":"];
                NSMutableDictionary *excpValues = [NSMutableDictionary dictionaryWithObjects:coordsA forKeys:[NSArray arrayWithObjects:@"Coordenada1",@"Posicao1",@"Coordenada2",@"Posicao2",@"Coordenada3",@"Posicao3", nil]];
                [excpValues setObject:msg forKey:@"message"];
                
                excp = [NSException exceptionWithName:@"CartaoMatriz" reason:@"Autenticacao" userInfo:excpValues];
                
            }else if([authType isEqualToString:@"NIF"]){
                
                NSString *pos = [comp objectAtIndex:1];
                NSArray *posA = [pos componentsSeparatedByString:@":"];
                NSMutableDictionary *excpValues = [NSMutableDictionary dictionaryWithObjects:posA forKeys:[NSArray arrayWithObjects:@"Posicao1",@"Posicao2", nil]];
                [excpValues setObject:msg forKey:@"message"];
                
                excp = [NSException exceptionWithName:@"Nif" reason:@"Autenticacao" userInfo:excpValues];
                
            }else if([authType isEqualToString:@"SMS_TOKEN"]){
                
                NSDictionary *excpValues = [NSDictionary dictionaryWithObject:msg forKey:@"message"];
                excp = [NSException exceptionWithName:@"SmsToken" reason:@"Autenticacao" userInfo:excpValues];
                
            }else{ //handle Unauthorized
                
                NSDictionary *excpValues = [NSDictionary dictionaryWithObject:msg forKey:@"message"];
                excp = [NSException exceptionWithName:type reason:@"NaoAutorizado" userInfo:excpValues];
                
            }
            
        }else{ //handle Unauthorized
            
            NSDictionary *excpValues = [NSDictionary dictionaryWithObject:msg forKey:@"message"];
            excp = [NSException exceptionWithName:type reason:@"NaoAutorizado" userInfo:excpValues];
            
        }
        
        @throw excp;
        
    }else if(httpResponse.statusCode == 403){   //Forbidden
        
        NSDictionary *excpValues = [NSDictionary dictionaryWithObject:msg forKey:@"message"];
        NSException *excp = [NSException exceptionWithName:@"SessaoExpirada" reason:@"Sessao" userInfo:excpValues];
        @throw excp;
        
    }else if(httpResponse.statusCode == 500){   //Internal Server Error
        
        NSException *excp;
        if(resultData){
            if([type isEqualToString:@"ar"]){
                NSDictionary *excpValues = [NSDictionary dictionaryWithObject:@"" forKey:@"message"];
                excp = [NSException exceptionWithName:@"CanalNaoAtivo" reason:@"ActivacaoCanal" userInfo:excpValues];
            }else{
                NSDictionary *excpValues = [NSDictionary dictionaryWithObject:msg forKey:@"message"];
                excp = [NSException exceptionWithName:type reason:@"Erro" userInfo:excpValues];
            }
        }else{
            NSDictionary *excpValues = [NSDictionary dictionaryWithObject:@"" forKey:@"message"];
            excp = [NSException exceptionWithName:@"ErroInterno" reason:@"Erro" userInfo:excpValues];
        }
        @throw excp;
        
    }else if(httpResponse.statusCode == 501){   //Not Implemented
        
        NSDictionary *excpValues = [NSDictionary dictionaryWithObject:msg forKey:@"message"];
        NSException *excp = [NSException exceptionWithName:@"VersaoNaoSuportada" reason:@"Versao" userInfo:excpValues];
        @throw excp;
        
    }else if(httpResponse.statusCode == 204){   //No Content
        
        NSDictionary *excpValues = [NSDictionary dictionaryWithObject:@"" forKey:@"message"];
        NSException *excp = [NSException exceptionWithName:@"Vazio" reason:@"SemConteudo" userInfo:excpValues];
        @throw excp;
        
    }else{
        
        NSDictionary *excpValues = [NSDictionary dictionaryWithObject:msg forKey:@"message"];
        NSException *excp = [NSException exceptionWithName:@"Generico" reason:@"Erro" userInfo:excpValues];
        @throw excp;
        
    }
    
    result.state = GMSFailure;
    result.msg = @"";
    return result;
}

+(GenericModel *) handleException:(NSException *)exc{
    GenericModel *result = [GenericModel new];
    
   if([exc.name isEqualToString:@"ProxyAuthentication"]){
        
        result.msg = @"PROXY";
        result.state = GMSProxy;
    }else{
        result.msg = [exc.userInfo objectForKey:@"message"];
        result.state = GMSFailure;
    }
    return result;
}

+(BOOL) handleState:(GenericModel *)model{

    if(model.state == GMSLogout){
        
        [APP_DELEGATE cancelPendingConnections];

        [UTILS performSelector:@selector(closePopup) withObject:nil afterDelay:10.0];
        
        return false;
    }
    else if(model.state == GMSVersionNotSupported){

        return false;
    }
    
    return true;
}

+(void) clearConnSessionData{
    NSHTTPCookieStorage * cookiesStor = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in [cookiesStor cookies]){
        if([[cookie name] isEqualToString:@"JSESSIONID"]){
            [cookiesStor deleteCookie:cookie];
        }
    }
}

@end
