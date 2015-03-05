//
//  HTNTableViewController.h
//  HTN Challenge
//
//  Created by Nolan Dey on 2015-02-22.
//  Copyright (c) 2015 Nolan Dey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTNTableViewController : UITableViewController

@property NSMutableArray *attendeeNames;
@property NSMutableArray *attendeeCompanies;
@property NSMutableArray *attendeeImages;
- (NSData*) RetrieveRawData;
- (NSMutableDictionary*) ConvertToJSONWithData:(NSData*)data;
- (void) loadDataFromArray:(NSMutableArray*)attendeeJSONArray;
- (void) doSomething;

@end
