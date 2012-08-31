/**
 **************************************************************************
 **                              QCard                                   **
 **************************************************************************
 * @package     app                                                      **
 * @subpackage  N/A                                                      **
 * @name        QCard                                                    **
 * @copyright   oohoo.biz                                                **
 * @link        http://oohoo.biz                                         **
 * @author      Theodore Pham                                            **
 * @license     http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later **
 **************************************************************************
 **************************************************************************/

#import "AnswerViewController.h"
#import "Singleton.h"
#import <AVFoundation/AVFoundation.h>

@interface AnswerViewController ()

@end

@implementation AnswerViewController

@synthesize playWord;

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
    //Background
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"try1.png"]];
    [super viewDidLoad];
    
    //Global variable
    Singleton *global = [Singleton globalVar];
    // Do any additional setup after loading the view from its nib.
    
    id str;
    
    //Checks if the start round is over
    if(global.initial_round != TRUE){
        //Grabs the value at specified index in array
        str = [global.initialAnswers objectAtIndex: global.index];
        
    } else {
        str = [global.skippedAnswers objectAtIndex: global.index];
    }
    
    //Display answer for the respective words
    lblANSWER.text = [NSString stringWithFormat:@"%@", str];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)goBack{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction) playSound{
//    Singleton *global = [Singleton globalVar];
    //Plays audio for correct answer
    //Reference:GeekyLemon -> http://www.youtube.com/watch?v=QuwTvg7Mi24
//    NSString *path = [[NSBundle mainBundle] pathForResource:[[global.answerArray objectAtIndex: global.index] lowercaseString] ofType:@"mp3"];
//    NSLog(@"%@", [[global.answerArray objectAtIndex: global.index] lowercaseString]);
//    NSLog(@"Method Called");
//
//    NSError *error = nil;    
//    AVAudioPlayer* theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&error];
//    if(theAudio){
//        [theAudio play];
//        NSLog(@"Playing Audio");
//
//    }

    
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"hello" ofType:@"mp3"];
//    AVAudioPlayer* theAudio = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
//    [theAudio play];
    [audioPlayer play];
}

@end
