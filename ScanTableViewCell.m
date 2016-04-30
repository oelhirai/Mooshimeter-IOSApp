/**************************
Mooshimeter iOS App - interface to Mooshimeter wireless multimeter
Copyright (C) 2015  James Whong

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
***************************/

#import "ScanTableViewCell.h"

@implementation ScanTableViewCell

-(ScanTableViewCell*) init {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ScanCell"];
    return self;
}

- (ScanTableViewCell*)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.hidesWhenStopped = YES;
    self.accessoryView = spinner;
    return self;
}

-(void) setPeripheral:(LGPeripheral *)device {
    uint32 build_time = 0;
    NSString* name_str;
    NSString* build_str;
    UIColor* back_color;
    
    self.p = device;
    
    UIActivityIndicatorView* spinner = (UIActivityIndicatorView*)self.accessoryView;
    
    if(device != nil) {
        
        switch(self.p.cbPeripheral.state) {
            case CBPeripheralStateDisconnected:
                self.backgroundColor = [UIColor whiteColor];
                [spinner stopAnimating];
                break;
            case CBPeripheralStateConnecting:
                self.backgroundColor = [UIColor orangeColor];
                [spinner startAnimating];
                break;
            case CBPeripheralStateConnected:
                self.backgroundColor = [UIColor greenColor];
                [spinner stopAnimating];
                break;
        }

        build_time = [MooshimeterDeviceBase getBuildTimeFromPeripheral:self.p];
        self.textLabel.text = [NSString stringWithFormat:@"%@",self.p.name];
        self.detailTextLabel.text = [NSString stringWithFormat:@"RSSI: %d        FW Build: %u",(int)self.p.RSSI, build_time];
    } else {
        NSLog(@"Shouldn't have received a nil device");
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
