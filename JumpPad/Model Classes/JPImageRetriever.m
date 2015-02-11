//
//  JPImageRetriever.m
//  Uniq
//
//  Created by Si Te Feng on 6/26/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "JPImageRetriever.h"

@implementation JPImageRetriever


+ (UIImage*)courseImageWithCourseName: (NSString*)name
{
    if(!name)
    {
        name = @"";
    }
    
    UIImage* image = [UIImage imageNamed:@"140-gradhat"];
    
    NSString* sub=[name lowercaseString];
    NSUInteger gr = 12;
    
    if([sub isEqualToString:@"science"]||[sub rangeOfString:@"chem"].length!=0)
    {
        if(gr>8)
        {
            image = [UIImage imageNamed:@"91-beaker-2.png"];
        }
        else
        {
            image = [UIImage imageNamed:@"92-test-tube.png"];
        }
    }
    else if([sub rangeOfString:@"read"].length!=0)
    {
        image = [UIImage imageNamed:@"96-book.png"];
    }
    else if([sub rangeOfString:@"grammar"].length!=0)
    {
        image = [UIImage imageNamed:@"179-notepad.png"];
    }
    else if([sub rangeOfString:@"new course" ].length!=0)
    {
        image = [UIImage imageNamed:@"courses-64"];
    }
    else if([sub rangeOfString:@"financ"].length!=0||[sub rangeOfString:@"econ"].length!=0)
    {
        image = [UIImage imageNamed:@"122-stats.png"];
    }
    else if([sub rangeOfString:@"math"].length!=0
            ||[sub rangeOfString:@"func"].length!=0||[sub rangeOfString:@"calc"].length!=0||[sub rangeOfString:@"alg"].length!=0||[sub rangeOfString:@"differential"].length!=0||[sub rangeOfString:@"data"].length!=0||[sub rangeOfString:@"num"].length!=0) {
        image = [UIImage imageNamed:@"161-calculator.png"];
    }
    else if([sub rangeOfString:@"english"].length!=0||[sub isEqualToString:@"spanish"]||[sub isEqualToString:@"french"]||[sub rangeOfString:@"chinese"].length!=0||[sub rangeOfString:@"arabic"].length!=0||[sub rangeOfString:@"german"].length!=0||[sub rangeOfString:@"fran"].length!=0||[sub rangeOfString:@"espan"].length!=0||[sub rangeOfString:@"literat"].length!=0)
    {
        image = [UIImage imageNamed:@"96-book.png"];
    }
    else if([sub rangeOfString:@"program"].length!=0||[sub rangeOfString:@"comp"].length!=0||[sub isEqualToString:@"cs"]||[sub rangeOfString:@"dev"].length!=0||[sub rangeOfString:@"mach"].length!=0)
    {
        image = [UIImage imageNamed:@"20-gear2.png"];

    }
    else if([sub rangeOfString:@"robot"].length!=0||[sub rangeOfString:@"tech"].length!=0||[sub rangeOfString:@"sens"].length!=0||[sub rangeOfString:@"sys"].length!=0||[sub rangeOfString:@"struc"].length!=0)
    {
        image = [UIImage imageNamed:@"19-gear.png"];
    }
    else if([sub isEqualToString:@"physics"]||[sub rangeOfString:@"glob"].length!=0)
    {
        image = [UIImage imageNamed:@"27-planet.png"];

    }
    else if([sub rangeOfString:@"spea"].length!=0)
    {
        image = [UIImage imageNamed:@"124-bullhorn.png"];

    }
    else if([sub isEqualToString:@"geometry"])
    {
        image = [UIImage imageNamed:@"186-ruler.png"];

    }
    
    else if([sub rangeOfString:@"bio"].length!=0||[sub rangeOfString:@"nutri"].length!=0)
    {
        image = [UIImage imageNamed:@"23-bird.png"];
 
    }
    else if([sub rangeOfString:@"film"].length!=0)
    {
        image = [UIImage imageNamed:@"43-film-roll.png"];

    }
    else if([sub rangeOfString:@"business"].length!=0)
    {
        image = [UIImage imageNamed:@"37-suitcase.png"];
    }
    else if([sub isEqualToString:@"gym"]||[sub isEqualToString:@"pe"]||[sub isEqualToString:@"physed"]||[sub rangeOfString:@"fit"].length!=0||[sub rangeOfString:@"weight"].length!=0||[sub rangeOfString:@"excercise"].length!=0)
    {
        image = [UIImage imageNamed:@"89-dumbell.png"];
   
    }
    else if([sub rangeOfString:@"astro"].length!=0)
    {
        image = [UIImage imageNamed:@"151-telescope.png"];
        
    }
    else if([sub rangeOfString:@"photo"].length!=0)
    {
        image = [UIImage imageNamed:@"86-camera.png"];

    }
    else if([sub isEqualToString:@"art"]||[sub rangeOfString:@"paint"].length!=0||[sub rangeOfString:@"visual"].length!=0)
    {
        image = [UIImage imageNamed:@"98-palette.png"];
        
    }
    else if([sub rangeOfString:@"art"].length!=0)
    {
        image = [UIImage imageNamed:@"29-heart.png"];
        
    }
    else if([sub rangeOfString:@"music"].length!=0||[sub rangeOfString:@"band"].length!=0||[sub isEqualToString:@"strings"]||[sub rangeOfString:@"jazz"].length!=0||[sub isEqualToString:@"orchestra"]||[sub rangeOfString:@"piano"].length!=0||[sub rangeOfString:@"viol"].length!=0)
    {
        image = [UIImage imageNamed:@"194-note-2.png"];
    }
    else if([sub rangeOfString:@"compu"].length!=0)
    {
        image = [UIImage imageNamed:@"174-imac.png"];
    }
    else if([sub rangeOfString:@"geography"].length!=0)
    {
        image = [UIImage imageNamed:@"73-radar.png"];
    }
    else if([sub rangeOfString:@"history"].length!=0)
    {
        image = [UIImage imageNamed:@"134-viking.png"];

    }
    else if([sub rangeOfString:@"debat"].length!=0)
    {
        image = [UIImage imageNamed:@"09-chat-2.png"];
    }
    else if([sub rangeOfString:@"digi"].length!=0)
    {
        image = [UIImage imageNamed:@"95-equalizer.png"];

    }
    else if([sub rangeOfString:@"strateg"].length!=0)
    {
        image = [UIImage imageNamed:@"101-gameplan.png"];

    }
    else if([sub rangeOfString:@"seminar"].length!=0)
    {
        image = [UIImage imageNamed:@"137-presentation.png"];
    }
    else if([sub rangeOfString:@"logic"].length!=0||[sub rangeOfString:@"philo"].length!=0||[sub rangeOfString:@"manage"].length!=0||[sub rangeOfString:@"soci"].length!=0||[sub rangeOfString:@"communi"].length!=0)
    {
        image = [UIImage imageNamed:@"112-group.png"];

    }
    else if([sub rangeOfString:@"static"].length!=0||[sub rangeOfString:@"mech"].length!=0||[sub rangeOfString:@"engine"].length!=0)
    {
        image = [UIImage imageNamed:@"158-wrench-2.png"];

    }
    else if([sub rangeOfString:@"therm"].length!=0||[sub rangeOfString:@"cryo"].length!=0||[sub rangeOfString:@"heat"].length!=0)
    {
        image = [UIImage imageNamed:@"93-thermometer.png"];

    }
    else if([sub rangeOfString:@"electric"].length!=0||[sub rangeOfString:@"power"].length!=0||[sub rangeOfString:@"curcuit"].length!=0)
    {
        image = [UIImage imageNamed:@"64-zap.png"];

    }
    else if([sub rangeOfString:@"stat"].length!=0||[sub rangeOfString:@"account"].length!=0)
    {
        image = [UIImage imageNamed:@"17-bar-chart.png"];

    }
    else
    {
        image = [UIImage imageNamed:@"140-gradhat.png"];
    }
    
    return image;
    
}


@end
