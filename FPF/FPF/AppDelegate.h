//
//  AppDelegate.h
//  FPF
//
//  Created by Vasco Ferreira on 5/23/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncURLConnection.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
        NSMutableArray *pendingConnections;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FPFUtils* utils;

-(NSString*) getURLRestWebService;

-(void)addToPendingConnections:(AsyncURLConnection *)conn;
-(void)removeFromPendingConnections:(AsyncURLConnection *)conn;
-(void)cancelPendingConnections;

@end
