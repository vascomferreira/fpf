//
//  ViewController.m
//  FPF
//
//  Created by Vasco Ferreira on 5/23/13.
//  Copyright (c) 2013 Armis. All rights reserved.
//

#import "ViewController.h"
#import "AccreditationsInvoker.h"

@interface ViewController ()
{
    NSMutableArray *arrayOfPerson;
    sqlite3 *personDB;
    NSString *dbPathString;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    arrayOfPerson = [[NSMutableArray alloc] init];
    [[self myTableView]setDelegate:self];
    [[self myTableView]setDataSource:self];
    [self createOrOpenDB];
    [self getAccreditations];
}

-(void) getAccreditations {
    AccreditationsListIn *input = [AccreditationsListIn new];
    input.eventID = 1;
    input.token = @"encryptedtoken";
    
    [AccreditationsInvoker getAccreditationsList:input completed:^(AccreditationsListOut *output) {
        
        //se reposta valida
        if(output.isValidServerResponse){
            NSLog(@"Obtever dados com sucesso");
        }
    }];
}

- (void)createOrOpenDB
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, TRUE);
    NSString *docPath = [path objectAtIndex:0];
    
    dbPathString = [docPath stringByAppendingPathComponent:@"persons.db"];
        
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:dbPathString]) {
        const char *dbPath = [dbPathString UTF8String];
        
        char *error;
        
        //create db here
        if (sqlite3_open(dbPath, &personDB)== SQLITE_OK) {
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS PERSONS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, AGE INTEGER)";
            sqlite3_exec(personDB, sql_stmt, NULL, NULL, &error);
            sqlite3_close(personDB);
        }
    }
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrayOfPerson count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    Person *aPerson = [arrayOfPerson objectAtIndex:indexPath.row];
    
    cell.textLabel.text = aPerson.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",aPerson.age];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addButton:(id)sender {
    char *error;
    if (sqlite3_open([dbPathString UTF8String], &personDB)== SQLITE_OK) {
        NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO PERSONS(NAME, AGE) values ('%s','%d')",[self.nameField.text UTF8String],[self.ageField.text intValue]];
        
        const char *insert_stmt = [insertStmt UTF8String];
        
        if (sqlite3_exec(personDB, insert_stmt, NULL, NULL, &error)==SQLITE_OK) {
            NSLog(@"Person added");
            
            Person *person = [[Person alloc] init];
            [person setName:self.nameField.text];
            [person setAge:[self.ageField.text intValue]];
            
            [arrayOfPerson addObject:person];
        }
        
        sqlite3_close(personDB);
    }
    
}

- (IBAction)displayButton:(id)sender {
    sqlite3_stmt *statement;
    
    if (sqlite3_open([dbPathString UTF8String], &personDB)== SQLITE_OK) {
        [arrayOfPerson removeAllObjects];
        
        NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM PERSONS"];
        const char *query_sql = [querySql UTF8String];
        
        if (sqlite3_prepare(personDB, query_sql, -1, &statement, NULL)==SQLITE_OK) {
            while (sqlite3_step(statement)==SQLITE_ROW) {
                NSString *name = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *ageString = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                
                Person *person = [[Person alloc]init];
                [person setName:name];
                [person setAge:[ageString intValue]];
                
                [arrayOfPerson addObject:person];
            }
        }
    }
    [[self myTableView]reloadData];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [[self ageField] resignFirstResponder];
    [[self nameField] resignFirstResponder];
}

- (IBAction)deleteButton:(id)sender {
    [[self myTableView] setEditing:!self.myTableView.editing animated:YES];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Person *p = [arrayOfPerson objectAtIndex:indexPath.row];
        [self deleteData:[NSString stringWithFormat:@"DELETE FROM PERSONS WHERE NAME IS '%s'",[p.name UTF8String]]];
        [arrayOfPerson removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)deleteData:(NSString *)deleteQuery {
    char *error;

    if (sqlite3_exec(personDB, [deleteQuery UTF8String], NULL, NULL, &error)==SQLITE_OK) {
        NSLog(@"Person deleted");
    }
    
    sqlite3_close(personDB);
}
@end
