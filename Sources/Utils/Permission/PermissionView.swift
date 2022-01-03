import UIKit

class PermissionView: UIView {
    
    lazy var imageView: UIImageView = self.makeImageView()
    lazy var label: UILabel = self.makeLabel()
    lazy var settingButton: UIButton = self.makeSettingButton()
    lazy var closeButton: UIButton = self.makeCloseButton()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    func setup() {
        [label, settingButton, closeButton, imageView].forEach {
            addSubview($0)
        }
        
        closeButton.g_pin(on: .top, constant: 20)
        closeButton.g_pin(on: .left)
        closeButton.g_pin(size: CGSize(width: 44, height: 44))
        
        settingButton.g_pinCenter()
        settingButton.g_pin(height: 44)
        
        label.g_pin(on: .bottom, view: settingButton, on: .top, constant: -24)
        label.g_pinHorizontally(padding: 50)
        
        imageView.g_pin(on: .centerX)
        imageView.g_pin(on: .bottom, view: label, on: .top, constant: -16)
    }
    
    // MARK: - Controls
    
    func makeLabel() -> UILabel {
        let label = UILabel()
        label.textColor = Config.Permission.textColor
        label.font = Config.Font.Text.regular.withSize(14)
        if Permission.Camera.needsPermission {
            label.text = Config.Localizations.galleryAndCameraPermissionInfo
        } else {
            label.text = Config.Localizations.galleryPermissionInfo
        }
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }
    
    func makeSettingButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(Config.Localizations.goToSettingsButtonTitle.uppercased(),
                        for: UIControl.State())
        button.backgroundColor = Config.Permission.Button.backgroundColor
        button.titleLabel?.font = Config.Font.Main.medium.withSize(16)
        button.setTitleColor(Config.Permission.Button.textColor, for: UIControl.State())
        button.setTitleColor(Config.Permission.Button.highlightedTextColor, for: .highlighted)
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        return button
    }
    
    func makeCloseButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(GalleryBundle.image("gallery_close")?.withRenderingMode(.alwaysTemplate), for: UIControl.State())
        button.tintColor = Config.Grid.CloseButton.tintColor
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return button
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.image = Config.Permission.image?.withRenderingMode(.alwaysTemplate)
        view.tintColor = UIColor.white
        return view
    }
}
