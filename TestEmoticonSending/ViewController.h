//
//  ViewController.h
//  TestEmoticonSending
//
//  Created by active on 2020/08/03.
//  Copyright © 2020 activeKJS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *Input;
- (IBAction)Convert:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *Output;

@end

