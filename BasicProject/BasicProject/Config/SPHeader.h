//
//  SPHeader.h
//  BasicProject
//
//  Created by WangJie on 2017/12/2.
//  Copyright © 2017年 SnoopPanda. All rights reserved.
//

#ifndef SPHeader_h
#define SPHeader_h

// Import 3rd-party, Common header

#import "UIView+Extension.h"
#import "UIView+Toast.h"
#import "Masonry.h"
#import "MJExtension.h"

#import "CocoaLumberjack.h"

#ifdef DEBUG
static DDLogLevel const ddLogLevel = DDLogLevelVerbose;
#else
static DDLogLevel const ddLogLevel = DDLogLevelOff;
#endif


#endif /* SPHeader_h */
