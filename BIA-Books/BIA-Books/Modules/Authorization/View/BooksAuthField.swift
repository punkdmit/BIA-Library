//
//  BooksAuth.swift
//  BIA-Books
//
//  Created by Alikin Nikita Romanovich on 17.02.2023.
//
import UIKit

class BiaBooksTextField: UITextField {
    enum FieldState {
        case unfocusedEmpty
        case focusedEmpty
        case unfocusedFilled
        case focusedFilled
        case disabledEmpty
        case disabledFilled
    }

    public var borderCornerRadius: CGFloat = 6.0
    public var labelScale: CGFloat = 12.0 / 14.0
    public var assistiveLabelPadding: CGFloat = 4.0
    public let label = UILabel()
    public let leadingAssistiveLabel = UILabel()
    public var textPadding = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16) // swiftlint:disable:this numbers_smell
    public var spacing: CGFloat = 4.0
    public var maxLength: Int = 0
    public var isNumericOnly: Bool = false
    private let titleHorizontalPadding = 4.0
    
    public var activeColor: UIColor = BooksColor.activeColor
    public var inactiveColor: UIColor = UIColor.clear
    public var errorColor: UIColor = BooksColor.redText
    public var primaryTextColor: UIColor = BooksColor.textPrimary
    public var secondaryTextColor: UIColor = BooksColor.textSecondary

    public var isTouchEnabled = true

    fileprivate var isError: Bool = false

    private var padding: UIEdgeInsets {
        UIEdgeInsets(top: textPadding.top,
                     left: leftViewMode == .never ? textPadding.left : spacing,
                     bottom: textPadding.bottom,
                     right: rightViewMode == .never ? textPadding.right: textPadding.right + spacing)
    }
//create border for textfield
    private var borderPath: CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.minX + max(textPadding.left - titleHorizontalPadding, titleHorizontalPadding), y: bounds.minY))
        path.addArc(withCenter: CGPoint(x: bounds.maxX - borderCornerRadius, y: bounds.minY + borderCornerRadius), radius: borderCornerRadius, startAngle: .pi * 1.5, endAngle: .pi * 0.0, clockwise: true)
        path.addArc(withCenter: CGPoint(x: bounds.maxX - borderCornerRadius, y: bounds.maxY - borderCornerRadius), radius: borderCornerRadius, startAngle: .pi * 0.0, endAngle: .pi * 0.5, clockwise: true)
        path.addArc(withCenter: CGPoint(x: bounds.minX + borderCornerRadius, y: bounds.maxY - borderCornerRadius), radius: borderCornerRadius, startAngle: .pi * 0.5, endAngle: .pi * 1.0, clockwise: true)
        path.addArc(withCenter: CGPoint(x: bounds.minX + borderCornerRadius, y: bounds.minY + borderCornerRadius), radius: borderCornerRadius, startAngle: .pi * 1.0, endAngle: .pi * 1.5, clockwise: true)
        path.close()
        return path.cgPath
    }

    private lazy var borderShapeLayer: CAShapeLayer = {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 1.0
        return shapeLayer
    }()

    private var trimFrom: CGFloat {
//        let circleLength: CGFloat = 2 * .pi * borderCornerRadius
//        let arcLength: CGFloat = 2 * borderCornerRadius
//        let shapeLength: CGFloat = 2 * (bounds.width - arcLength) + 2 * (bounds.height - arcLength) + circleLength
//        let trimFrom: CGFloat = label.frame.width.isZero ? 0 : (label.frame.width + 2 * titleHorizontalPadding) / shapeLength
//        let trimFrom = CGFloat()
        return 0
    }

    private var labelTransform: CGAffineTransform {
        self.layoutIfNeeded()
        return Transform(frame: label.bounds, xScale: labelScale, yScale: labelScale, anchorPoint: .centerLeft).transform
//            .concatenating(CGAffineTransform(translationX: 0, y: -bounds.height / 2))
            .concatenating(CGAffineTransform(translationX: 0, y: -bounds.height / 2 - label.bounds.height / 2 - 1))
    }

    private var fieldState: FieldState {
        let isEmpty = (self.text?.isEmpty == true) && leftViewMode == .never
        if !isEnabled && isEmpty { return .disabledEmpty }
        if !isEnabled && !isEmpty { return .disabledFilled }
        if isEditing && isEmpty { return .focusedEmpty }
        if !isEditing && isEmpty { return .unfocusedEmpty }
        if isEditing && !isEmpty { return .focusedFilled }
        return .unfocusedFilled
    }

    override var isEnabled: Bool {
        didSet { isEnabledDidChange() }
    }

    override var text: String? {
        didSet { updateLayout() }
    }

    override var placeholder: String? {
        didSet {
            guard let text = self.placeholder else { return }
            self.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: secondaryTextColor])
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: padding)
    }

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.leftViewRect(forBounds: bounds)
        return rect.offsetBy(dx: textPadding.left, dy: 0)
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.rightViewRect(forBounds: bounds)
        return rect.offsetBy(dx: -textPadding.right, dy: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        drawBorder()
    }

    private func sharedInit() {
        setup()
    }

    private func setup() {
        setupTextField()
        setupLabel()
        setupAssistiveLabel()
        setupBorder()
        updateLayout()
        self.delegate = self
    }

    private func setupTextField() {
        self.tintColor = BooksColor.textPrimary
    }

    private func setupLabel() {
        label.font = self.font
        label.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textPadding.left)
        ])
    }

    private func setupAssistiveLabel() {
        if let font = self.font { leadingAssistiveLabel.font = font.withSize(font.pointSize * labelScale) }
        leadingAssistiveLabel.numberOfLines = 0
        leadingAssistiveLabel.sizeToFit()

        self.addSubview(leadingAssistiveLabel)

        leadingAssistiveLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            leadingAssistiveLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: assistiveLabelPadding),
            leadingAssistiveLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textPadding.left),
            self.trailingAnchor.constraint(equalTo: leadingAssistiveLabel.trailingAnchor, constant: textPadding.right)
        ])
    }

    private func setupBorder() {
        self.borderStyle = .none
        self.layer.addSublayer(borderShapeLayer)
    }

    private func isEnabledDidChange() {
        updateLayout()
    }

    private func drawBorder() {
        guard borderShapeLayer.bounds != self.bounds else { return }

        borderShapeLayer.path = borderPath
        borderShapeLayer.strokeStart = [.unfocusedEmpty, .disabledEmpty].contains(fieldState) ? 0 : trimFrom
    }

    private func animateTransitionIfNeeded(toState: FieldState) {
        let transitionAnimator = UIViewPropertyAnimator(duration: 0.2, dampingRatio: 1) { [weak self] in
            guard let self = self else { return }

            switch toState {
            case .unfocusedEmpty:
                self.label.transform = .identity
                self.label.textColor = self.secondaryTextColor
                self.leadingAssistiveLabel.textColor = self.isError ? self.errorColor : self.secondaryTextColor
                self.borderShapeLayer.strokeColor = self.isError ? self.errorColor.cgColor : self.inactiveColor.cgColor
                self.textColor = self.primaryTextColor

            case .focusedEmpty:
                self.label.transform = self.labelTransform
                self.label.textColor = self.isError ? self.errorColor : self.secondaryTextColor
                self.leadingAssistiveLabel.textColor = self.isError ? self.errorColor : self.secondaryTextColor
                self.borderShapeLayer.strokeColor = self.isError ? self.errorColor.cgColor : self.activeColor.cgColor
                self.textColor = self.primaryTextColor

            case .unfocusedFilled:
                self.label.transform = self.labelTransform
                self.label.textColor = self.isError ? self.errorColor : self.secondaryTextColor
                self.leadingAssistiveLabel.textColor = self.isError ? self.errorColor : self.secondaryTextColor
                self.borderShapeLayer.strokeColor = self.isError ? self.errorColor.cgColor : self.inactiveColor.cgColor
                self.textColor = self.primaryTextColor

            case .focusedFilled:
                self.label.transform = self.labelTransform
                self.label.textColor = self.isError ? self.errorColor : self.secondaryTextColor
                self.leadingAssistiveLabel.textColor = self.isError ? self.errorColor : self.secondaryTextColor
                self.borderShapeLayer.strokeColor = self.isError ? self.errorColor.cgColor : self.activeColor.cgColor
                self.textColor = BooksColor.textPrimary

            case .disabledEmpty:
                self.label.transform = .identity
                self.label.textColor = self.inactiveColor.withAlphaComponent(0.3)
                self.leadingAssistiveLabel.textColor = self.secondaryTextColor.withAlphaComponent(0.3)
                self.borderShapeLayer.strokeColor = self.inactiveColor.withAlphaComponent(0.3).cgColor
                self.textColor = self.primaryTextColor.withAlphaComponent(0.3)

            case .disabledFilled:
                self.label.transform = self.labelTransform
                self.label.textColor = self.inactiveColor.withAlphaComponent(0.3)
                self.leadingAssistiveLabel.textColor = self.secondaryTextColor.withAlphaComponent(0.3)
                self.borderShapeLayer.strokeColor = self.inactiveColor.withAlphaComponent(0.3).cgColor
                self.textColor = self.primaryTextColor.withAlphaComponent(0.3)
            }
        }

        transitionAnimator.startAnimation()
    }

    public func updateLayout() {
        animateTransitionIfNeeded(toState: fieldState)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateLayout()
        }
    }

}

extension BiaBooksTextField {

    func set(text: String) {
        guard self.text != text else { return }
        self.text = text
    }

    func set(isError: Bool) {
        guard self.isError != isError else { return }
        self.isError = isError
        updateLayout()
    }

    func set(leadingAssistiveLabelText text: String) {
        guard leadingAssistiveLabel.text != text else { return }
        leadingAssistiveLabel.text = text
    }

    func set(borderColor: CGColor) {
        borderShapeLayer.strokeColor = borderColor
    }
}

extension BiaBooksTextField : UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateLayout()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateLayout()
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if isNumericOnly, !(string.isNumeric || string == "") { return false }
        guard maxLength > 0, let oldText = textField.text else { return true }
        let newText = (oldText as NSString).replacingCharacters(in: range, with: string)
        return newText.count <= maxLength
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return isTouchEnabled
    }
}

private enum AnchorPoint {
    case center
    case topLeft
    case centerLeft
    case bottomLeft
    case topRight
    case centerRight
    case bottomRight
}

private class Transform {
    private var frame: CGRect
    private var xScale: CGFloat
    private var yScale: CGFloat
    private var anchorPoint: AnchorPoint

    var transform: CGAffineTransform {
        var xSign: CGFloat = 0
        var ySign: CGFloat = 0

        switch self.anchorPoint {
        case .center:
            xSign = 0
            ySign = 0
        case .topLeft:
            xSign = 1
            ySign = 1
        case .centerLeft:
            xSign = 1
            ySign = 0
        case .bottomLeft:
            xSign = 1
            ySign = -1
        case .topRight:
            xSign = -1
            ySign = 1
        case .centerRight:
            xSign = -1
            ySign = 0
        case .bottomRight:
            xSign = -1
            ySign = -1
        }

        let xShift = (frame.width * xScale - frame.width) / 2 * xSign
        let yShift = (frame.height * yScale - frame.height) / 2 * ySign

        return CGAffineTransform(scaleX: self.xScale, y: self.yScale).concatenating(CGAffineTransform(translationX: xShift, y: yShift))
    }

    init(frame: CGRect, xScale: CGFloat, yScale: CGFloat, anchorPoint: AnchorPoint) {
        self.xScale = xScale
        self.yScale = yScale
        self.anchorPoint = anchorPoint
        self.frame = frame
    }
}
