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
#import <UIKit/UIKit.h>


@interface HTNTableViewController ()

@end

@implementation HTNTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.attendeeNames = [[NSMutableArray alloc] init];
//    self.attendeeCompanies = [[NSMutableArray alloc] init];
//    self.attendeeImages = [[NSMutableArray alloc] init];
    self.attendees = [[NSMutableArray alloc] init];
    
    //retrieves data from URL and stores is in an NSData object
    NSData *rawData = [self RetrieveRawData];
    
    //converts the JSON data into an NSMutableDictionary
    NSMutableDictionary *attendeeDictionary = [self ConvertToJSONWithData:rawData];
    
    //stores the data for each user into an element of the attendeeJSONArray
    NSMutableArray *attendeeJSONArray = [[NSMutableArray alloc] init];
    attendeeJSONArray = [attendeeDictionary objectForKey:@"users"];
    
    //stores the name, company, and picture for each user into an the attendees array
    [self loadDataFromArray:attendeeJSONArray];
   
//    [NSThread detachNewThreadSelector:@selector(loadDataFromArray:)
//                             toTarget:self withObject:attendeeJSONArray];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
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
    return [self.attendees count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HTNCell" forIndexPath:indexPath];
    
    HTNAttendee *person = self.attendees[indexPath.row];
    
    cell.textLabel.text = person.name;
    cell.detailTextLabel.text = person.company;
    cell.imageView.image = person.image;
    
    
    
    return cell;
}

//- (void)tableView:(NSTableView *)tableView sortDescriptorsDidChange:(NSArray*)oldDescriptors
//{
//    [peopleArray sortUsingDescriptors: [tableView sortDescriptors]];
//    [tableView reloadData];
//}
//
//
//NSSortDescriptor *titleSorter= [[NSSortDescriptor alloc] initWithKey:@"annotationLocation" ascending:YES];
//[arrayOfObjects sortUsingDescriptors:[NSArray arrayWithObject:titleSorter];

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

- (void) loadDataFromArray:(NSMutableArray*)attendeeJSONArray {
    
    //for (int i = 0; i < 1212; i++){
    for (int i = 0; i < 10; i++){
        NSDictionary *personData = attendeeJSONArray[i];
        HTNAttendee *personInfo = [[HTNAttendee alloc] init];
        
        //extracts specific attendee data from personData dictionary and stores it in personInfo
        personInfo.name = [personData objectForKey:@"name"];
        personInfo.company = [personData objectForKey:@"company"];
        NSString *pictureURL = [personData objectForKey:@"picture"];
        personInfo.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:pictureURL]]];
        
        [self.attendees addObject:personInfo];
        
    }
}


@end
