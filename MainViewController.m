//
//  MainViewController.m
//  paperGesture
//
//  Created by Natalia Fisher on 7/6/14.
//  Copyright (c) 2014 Google. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *newsScroll;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
@property (weak, nonatomic) IBOutlet UIView *newsView;
- (IBAction)newsPanGesture:(UIPanGestureRecognizer *)sender;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self.newsScroll setContentSize:self.newsImage.frame.size];
    self.newsScroll.contentSize=CGSizeMake(1300,200);

    
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newsPanGesture:(UIPanGestureRecognizer *)sender {
    
    CGPoint location = [sender locationInView:self.view];
    static CGRect originalFrame;

    if (sender.state == UIGestureRecognizerStateBegan) {
        originalFrame = sender.view.frame;
        
    } else if (sender.state == UIGestureRecognizerStateChanged){
        
        //NSLog(@"Pan gesture changed: %@", NSStringFromCGPoint(location));
        
        // Get translation
        CGPoint translate = [sender translationInView:self.view];
        
        if ((originalFrame.origin.y < 0) && (translate.y < 0)) {
            NSLog(@"Using friction");
        // Use friction if trying to pull past the top
        sender.view.frame = CGRectMake(originalFrame.origin.x,
                                       originalFrame.origin.y + (translate.y * .1),
                                       originalFrame.size.width,
                                       originalFrame.size.height);
        } else {
          // Otherwise drag normally
           NSLog(@"NO friction");
          sender.view.frame = CGRectMake(originalFrame.origin.x,
                                           originalFrame.origin.y + (translate.y),
                                           originalFrame.size.width,
                                           originalFrame.size.height);
            
        }
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"Pan gesture ended");
        // If y is greater than 300
        if (location.y > 300) {
            // then animate newsView to the bottom of the screen
            [UIView animateWithDuration:.5 animations:^{
                self.newsView.center = CGPointMake(160,805);
            }];
        }
        else {
            // otherwise animate back to the top of the screen
            [UIView animateWithDuration:.5 animations:^{
                self.newsView.center = CGPointMake(160,280);
            }];
        }
        
    }
}
@end
