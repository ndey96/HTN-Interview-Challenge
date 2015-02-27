//
//  HTNUITableViewCell.h
//  HTN Challenge
//
//  Created by Nolan Dey on 2015-02-22.
//  Copyright (c) 2015 Nolan Dey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTNUITableViewCell : UITableViewCell

- (void) populateName:(NSString*)name;
- (void) populateCompany:(NSString*)company;
- (void) populateImage:(NSString*)url;

@end
