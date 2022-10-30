import UIKit

extension ColorPaletteView {
    public final class ColorSliderView: UIControl {
        private(set) var value: Float
        private let slider = UISlider()
        public let colorLabel = UILabel()
        
        init(colorName: String, value: Float) {
            self.value = value
            super.init(frame: .zero)

            colorLabel.text = colorName
            colorLabel.textColor = .systemGray
            colorLabel.font = .systemFont(ofSize: 14.0, weight: .regular)

            setupView()
            slider.value = value
            slider.addTarget(self, action: #selector(sliderMoved(_:)), for: .touchDragInside)
            slider.addTarget(self, action: #selector(sliderPressed), for: .touchDown)
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupView() {
            let stackView = UIStackView(arrangedSubviews: [colorLabel, slider])
            stackView.axis = .horizontal
            stackView.spacing = 8
            
            addSubview(stackView)
            stackView.pin(to: self, [.top, .left, .bottom, .right], 12)
        }
        
        @objc
        private func sliderMoved(_ slider: UISlider) {
            self.value = slider.value
            sendActions(for: .touchDragInside)
        }
        
        @objc
        private func sliderPressed(_ slider: UISlider) {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
    }
}
