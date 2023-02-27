import UIKit

extension UIButton {
    
    func addBadge() {
        let uiView = UIView(frame: CGRect(x: 9, y: 4, width: 16, height: 16))
        uiView.backgroundColor = .ypRed
        uiView.layer.cornerRadius = 8
        uiView.layer.masksToBounds = true
        uiView.layer.borderColor = UIColor.ypFullBlack.cgColor
        uiView.layer.borderWidth = 2
        uiView.tag = 666
        self.addSubview(uiView)
    }
    
    func removeBadge() {
        if let viewToRemove = self.subviews.last {
            if viewToRemove.tag == 666 {
                viewToRemove.removeFromSuperview()
            }
        }
    }
}
