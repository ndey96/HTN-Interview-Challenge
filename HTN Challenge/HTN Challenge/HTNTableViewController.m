//
//  HTNTableViewController.m
//  HTN Challenge
//
//  Created by Nolan Dey on 2015-02-22.
//  Copyright (c) 2015 Nolan Dey. All rights reserved.
//

#import "HTNTableViewController.h"
#import <Foundation/Foundation.h>
#import "HTNAttendee.h"

@interface HTNTableViewController ()

@end

@implementation HTNTableViewController

-(void) loadDataFromArray:(NSMutableArray*)attendeeJSONArray {

    //for (int i = 0; i < 1212; i++){
    for (int i = 0; i < 5; i++){
        NSDictionary *personData = attendeeJSONArray[i];
        HTNAttendee *personInfo = [[HTNAttendee alloc] init];
        
        //extracts attendee data from personData dictionary
        personInfo.name = [personData objectForKey:@"name"];
        personInfo.company = [personData objectForKey:@"company"];
        personInfo.imageURL = [personData objectForKey:@"picture"];
        
        //populates the TableViewController's arrays with the attendee data
        [self.attendeeNames addObject:personInfo.name];
        [self.attendeeCompanies addObject:personInfo.company];
        [self.attendeeImages addObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:personInfo.imageURL]]]];
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.attendeeNames = [[NSMutableArray alloc] init];
    self.attendeeCompanies = [[NSMutableArray alloc] init];
    self.attendeeImages = [[NSMutableArray alloc] init];
    
    NSData *rawData = [self RetrieveRawData];
    NSMutableDictionary *attendeeDictionary = [self ConvertToJSONWithData:rawData];
    NSMutableArray *attendeeJSONArray = [[NSMutableArray alloc] init];
    attendeeJSONArray = [attendeeDictionary objectForKey:@"users"];
    //each element of the attendeeArray holds the data for one user
    //NSLog(@"the size is %lu",(unsigned long)[attendeeJSONArray count]);
    //prints number of attendees
    [self loadDataFromArray:attendeeJSONArray];
   
//    [NSThread detachNewThreadSelector:@selector(loadDataFromArray:)
//                             toTarget:self withObject:attendeeJSONArray];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.attendeeNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTNCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.attendeeNames[indexPath.row];
    cell.detailTextLabel.text = self.attendeeCompanies[indexPath.row];
    cell.imageView.image = self.attendeeImages[indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) doSomething {
    NSLog(@"ndsvoidsn");
}

- (NSData*) RetrieveRawData {
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://htn15-interviews.firebaseio.com/.json"]];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    return data;
}

- (NSMutableDictionary*) ConvertToJSONWithData:(NSData*)data {
    
    NSError *error = nil;
    NSMutableDictionary *attendeeProfiles = [NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingMutableContainers error:&error];
    return attendeeProfiles;
}

@end
