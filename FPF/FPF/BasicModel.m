//
//  BasicModel.m
//  FPF
//
//  Created by Vasco Ferreira on 5/24/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import "BasicModel.h"

@implementation BasicModel

-(id) initWithDictionary:(NSDictionary*) _dic{
    if((self = [super init])){
        dic = _dic;
    }
    return self;
}

+(NSString*) getEstadoOperacaoCode:(ESTADO_OPERACAO) state{
    switch (state) {
        case ESTADO_OPERACAO_FAILED:
            return @"FL";
            break;
        case ESTADO_OPERACAO_PENDING:
            return @"PD";
            break;
        case ESTADO_OPERACAO_SUCCEEDED:
            return @"SC";
        default:
            break;
    }
}
+(ESTADO_OPERACAO) getEstadoOperacao:(NSString*) state{
    if((id) state == [NSNull null]) return ESTADO_OPERACAO_FAILED;
    
    if([state isEqualToString:@"FL"]) return ESTADO_OPERACAO_FAILED;
    else if([state isEqualToString:@"PD"]) return ESTADO_OPERACAO_PENDING;
    else if([state isEqualToString:@"SC"]) return ESTADO_OPERACAO_SUCCEEDED;
    
    return ESTADO_OPERACAO_FAILED;
}

@end
