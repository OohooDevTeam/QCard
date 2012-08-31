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

@interface SetupViewController : UIViewController
<UIPickerViewDelegate, UIPickerViewDataSource>
{
    //Mutable array contents can be changed while NSArray contents cannot be changed without recreating it
	NSMutableArray *langarrayNo;
    NSMutableArray *setarrayNo;
    
    IBOutlet UILabel *langlabel; 
    IBOutlet UILabel *setlabel;
    
	IBOutlet UIPickerView *pickerView;
    
    IBOutlet UIButton *langButton;
    IBOutlet UIButton *setButton;
    
}

//- (IBAction) langButtonAction;

@property (nonatomic, retain) UILabel *langlabel;
@property (nonatomic, retain) UILabel *setlabel;

@property (nonatomic, strong) IBOutlet UIButton *langButton;
@property (nonatomic, strong) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) IBOutlet UIButton *setButton;

@end
