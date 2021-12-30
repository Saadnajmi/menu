#import <React/RCTComponent.h>
#import <React/RCTViewManager.h>

@class RNCMenuView; 

@implementation RCTConvert (RNCMenuViewManager)

+ (NSMenuItem *)NSMenuItem:(id)json
{
  NSMenuItem *menuItem = [[NSMenuItem alloc] init];
  [menuItem setTitle:[RCTConvert NSString:json[@"title"]]];
  [menuItem setImage:[RCTConvert UIImage:json[@"image"]]];
  [menuItem setEnabled:[RCTConvert BOOL:json[@"enabled"]]];
  [menuItem setToolTip:[RCTConvert NSString:json[@"tooltip"]]];
  [menuItem setIdentifier:[RCTConvert NSString:json[@"identifier"]]];
  return menuItem;
}

+ (NSMenu *)NSMenu:(id)json
{
  NSMenu *menu = [[NSMenu alloc] init];
  [menu setAutoenablesItems:NO];

  NSArray *menuItems = [RCTConvert NSArray:json];
  for (NSDictionary *menuItemJson in menuItems) {
    NSMenuItem *menuItem = [RCTConvert NSMenuItem:menuItemJson];

    // Recursively parse and assign the submenu to the menu item
    if ([menuItemJson objectForKey:@"hasSubmenu"])
    {
      BOOL hasSubmenu = [RCTConvert BOOL:menuItemJson[@"hasSubmenu"]];
      if (hasSubmenu) {
        NSMenu *submenu = [RCTConvert NSMenu:menuItemJson[@"submenu"]];
        [menu setSubmenu:submenu forItem:menuItem];
      }
    }
    [menu addItem:menuItem];
  }
  return menu;
}

+ (NSMenuItem *)action:(id)json
{
	NSMenuItem *menuItem = [[NSMenuItem alloc] init];
	
	[menuItem setIdentifier:[RCTConvert NSString:json[@"id"]]];
	
	NSString *title = [RCTConvert NSString:json[@"title"]];
	NSColor *titleColor = [RCTConvert UIColor:json[@"titleColor"]];
	NSAttributedString *attributedTitle = [[NSAttributedString alloc]
										   initWithString:title
										   attributes:@{NSForegroundColorAttributeName: titleColor}];
	[menuItem setAttributedTitle:attributedTitle];
	
	NSDictionary *attributes = [RCTConvert NSDictionary:@"attributes"];
	BOOL enabled = !attributes[@"disabled"];
	BOOL hidden = [attributes[@"hidden"] boolValue];
	[menuItem setEnabled:enabled];
	[menuItem setHidden:hidden];
	
	// TODO: Make an enum converter for state
// [menuItem setState:nil];
	
	// TODO: Support SF Symbol images with a color
//	NSImageName imageName = [RCTConvert NSString:json[@"image"]];
//	if (@available(macOS 11.0, *)) {
//		NSImage *image = [NSImage imageWithSystemSymbolName:imageName
//				  accessibilityDescription:nil];
//		[menuItem setImage:image];
//	} else {
//		// Fallback on earlier versions
//		NSImage *image = [NSImage imageNamed:imageName];
//		[menuItem setImage:image];
//	}

  return menuItem;
}

@end


@interface RCT_EXTERN_MODULE(RNCMenuViewManager, RCTViewManager)

RCT_REMAP_VIEW_PROPERTY(content, title, NSString)

RCT_EXPORT_VIEW_PROPERTY(image, UIImage)

RCT_EXPORT_VIEW_PROPERTY(enabled, BOOL)

RCT_EXPORT_VIEW_PROPERTY(menu, NSMenu)

RCT_EXPORT_VIEW_PROPERTY(onItemClick, RCTBubblingEventBlock)

RCT_EXPORT_VIEW_PROPERTY(onSubmenuItemClick, RCTBubblingEventBlock)

//(name, type, viewClass)

RCT_CUSTOM_VIEW_PROPERTY(actions, NSArray, RNCMenuView)
{
	NSArray *actions = [RCTConvert NSArray:json];
}

@end
