//
//  ViewController.h
//  FPF
//
//  Created by Vasco Ferreira on 5/23/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
#import "Person.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *ageField;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)addButton:(id)sender;
- (IBAction)displayButton:(id)sender;
- (IBAction)deleteButton:(id)sender;

@end
