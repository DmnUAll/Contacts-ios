import UIKit

// MARK: - UICreator
struct UICreator {

    static let shared = UICreator()
    
    func makeLabel(text: String? = nil,
                   font: UIFont?,
                   alignment: NSTextAlignment = .center,
                   color: UIColor = .ypWhite
    ) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textAlignment = alignment
        label.text = text
        label.textColor = color
        return label
    }

    func makeImageView(withImage image: UIImage? = nil, backgroundColor: UIColor = .clear, cornerRadius: CGFloat = 0, borderWidth: CGFloat = 0, isHidden: Bool = false) -> UIImageView {
        let imageView = UIImageView()
        imageView.isHidden = isHidden
        imageView.image = image
        imageView.backgroundColor = backgroundColor
        imageView.layer.cornerRadius = cornerRadius
        imageView.layer.borderColor = UIColor.ypBlack.cgColor
        imageView.layer.borderWidth = borderWidth
        imageView.layer.masksToBounds = true
        return imageView
    }
    
    func makeButton(withTitle title: String? = nil, backgroundColor: UIColor = .clear, image: UIImage? = nil, cornerRadius: CGFloat = 0, action: Selector) -> UIButton {
        let button = UIButton()
        button.backgroundColor = backgroundColor
        button.titleLabel?.font = UIFont.appFont(.medium, withSize: 16)
        button.titleLabel?.textColor = .ypWhite
        button.setTitle(title, for: .normal)
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = cornerRadius
        button.layer.masksToBounds = true
        button.addTarget(nil, action: action, for: .touchUpInside)
        return button
    }
    
    func makeTableView(withCells cells: (type: UITableViewCell.Type, identifier: String)...) -> UITableView {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        for singleCell in cells {
            tableView.register(singleCell.type, forCellReuseIdentifier: singleCell.identifier)
        }
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        return tableView
    }
    
    func makeView(bacgroundColor: UIColor = .clear) -> UIView {
        let uiView = UIView()
        uiView.backgroundColor = bacgroundColor
        return uiView
    }
    
    func makeStackView(axis: NSLayoutConstraint.Axis = .horizontal,
                       alignment: UIStackView.Alignment = .fill,
                       distribution: UIStackView.Distribution = .fill,
                       backgroundColor: UIColor = .clear,
                       addingSpacing spacing: CGFloat = 4
    ) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.backgroundColor = backgroundColor
        stackView.spacing = spacing
        return stackView
    }
}
