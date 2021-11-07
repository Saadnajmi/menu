import Foundation

@objc(RNCMenuViewManager)
class MenuViewManager: RCTViewManager {
  override func view()->NSView! {
    return MenuButton()
  }

  override class func requiresMainQueueSetup() -> Bool {
    return true
  }
}
