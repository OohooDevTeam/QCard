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

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "audioControl.h"

@interface AnswerViewController : UIViewController{
    
    IBOutlet UIButton *playWord;

    IBOutlet UILabel *lblANSWER;
    
    audioControl *audio;
    char audioFilePath[256];
    AVAudioPlayer *audioPlayer;
    
}

- (IBAction) playSound;
- (IBAction) goBack;

@property (nonatomic, strong) IBOutlet UIButton *playWord;

@end
