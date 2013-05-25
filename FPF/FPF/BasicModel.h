//
//  BasicModel.h
//  FPF
//
//  Created by Vasco Ferreira on 5/24/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ESTADO_OPERACAO_PENDING = 1, //Pending
    ESTADO_OPERACAO_SUCCEEDED = 2, //Succeeded
    ESTADO_OPERACAO_FAILED = 3  //Failed
} ESTADO_OPERACAO;

@interface BasicModel : NSObject{
    NSDictionary *dic;
}

-(id)initWithDictionary:(NSDictionary*) _dic;
+(NSString*) getEstadoOperacaoCode:(ESTADO_OPERACAO) state;
+(ESTADO_OPERACAO) getEstadoOperacao:(NSString*) state;

@end
