
import UIKit

class Ying: UIView{
        
    override func draw(_ rect: CGRect) {
        draw(rect: rect, color: .black)
    }

    private func draw(rect: CGRect, color: UIColor) {
        let center1 = CGPoint(x: rect.origin.x + rect.width / 4, y: rect.origin.y + rect.height / 2)
        let center2 = CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y + rect.height / 2)
        let center3 = CGPoint(x: rect.origin.x + rect.width / 2 + rect.width / 4, y: rect.origin.y + rect.height / 2)
        let radiusBig = min(rect.width, rect.height) / 2
        let radiusSmall = min(rect.width / 2, rect.height / 2) / 2
        let radiusCircle = min(rect.width, rect.height) / 6
        let path = UIBezierPath()
        path.usesEvenOddFillRule = false
        
        let arc = UIBezierPath(arcCenter: center3, radius: radiusSmall, startAngle: 0, endAngle: .pi, clockwise: true)
        let circle = UIBezierPath(ovalIn: CGRect(x: center1.x - radiusCircle/2, y: center1.y - radiusCircle/2, width: radiusCircle, height: radiusCircle))
        let circle2 = UIBezierPath(ovalIn: CGRect(x: center3.x - radiusCircle/2, y: center3.y - radiusCircle/2, width: radiusCircle, height: radiusCircle))
        
        path.addArc(withCenter: center1, radius: radiusSmall, startAngle: .pi, endAngle: 0, clockwise: true)
        path.addArc(withCenter: center2, radius: radiusBig, startAngle: 0, endAngle: .pi, clockwise: true)
        path.append(arc.reversing())
        path.append(circle.reversing())
        path.append(circle2)
        path.close()
        color.setFill()
        path.fill()
        
        
        
    }
}

class Arc: UIView{
    
    override func draw(_ rect: CGRect) {
        draw(rect: rect, color: .black)
    }

    private func draw(rect: CGRect, color: UIColor) {
        
        let center = CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y + rect.height / 2)
        let radiusBig = min(rect.width, rect.height) / 2
        let path = UIBezierPath()
        path.usesEvenOddFillRule = false
        path.addArc(withCenter: center, radius: radiusBig, startAngle: 0, endAngle: .pi, clockwise: true)
        path.close()
        path.fill()
    }
}

class Circle: UIView{
    
    override func draw(_ rect: CGRect) {
        draw(rect: rect, color: .white)
    }

    private func draw(rect: CGRect, color: UIColor) {
        
        let center = CGPoint(x: rect.origin.x, y: rect.origin.y)
        let radius = min(rect.width, rect.height)
        let path = UIBezierPath()
        path.usesEvenOddFillRule = false
        
        let circle = UIBezierPath(ovalIn: CGRect(x: center.x, y: center.y, width: radius, height: radius))
        path.append(circle)
        path.close()
        color.setFill()
        path.fill()
    }
    
    
}

class YingYang: UIView{
    let ying = Ying(frame: .zero)
    let circle = Circle(frame: .zero)
    let ying2 = Ying(frame: .zero)
    let circle2 = Circle(frame: .zero)
    let circle3 = Circle(frame: .zero)
    let arc = Arc(frame: .zero)
    
    
    
    func setup(mainView : UIView, rect : CGRect, duration : Double = 3) -> UIView{
        
        let centerOfView = rect.center
        let n = min(rect.height, rect.width)
        
        let arr : Array<UIView> = [arc, circle, circle2, ying, ying2]
        let offsets : Array<CGFloat> = [n/2, n/4, (n/2)+(n/4), n/4, (n/2)+(n/4)]
        let sizes : Array<CGFloat> = [n, n/2, n/2, n/2, n/2]
        
        
        circle3.center = CGPoint(x: centerOfView.x, y: centerOfView.y)
        circle3.bounds = CGRect(x: centerOfView.x, y: centerOfView.y, width: n, height: n)
        circle3.backgroundColor = .clear
        
        var iter = 0
        while iter < arr.count{
            let obj = arr[iter]
            
            obj.center = CGPoint(x: circle3.center.x + offsets[iter], y: circle3.center.y + n/2)
            obj.bounds = CGRect(x: obj.center.x, y: obj.center.y, width: sizes[iter], height: sizes[iter])
            obj.backgroundColor = .clear
            
            circle3.addSubview(obj)
            
            iter += 1
        }
        
        rotateView(duration: duration)
        
        return circle3
    }

    func rotateView(duration: Double) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
            self.ying.transform = self.ying.transform.rotated(by: .pi)
            self.ying2.transform = self.ying2.transform.rotated(by: .pi)
            self.circle3.transform = self.circle3.transform.rotated(by: .pi)
        }) { (_) -> Void in
            self.rotateView(duration: duration)
        }
    }
    
}

extension CGRect {
    var center: CGPoint { return CGPoint(x: midX, y: midY) }
}

class YingYangBigger: UIView{
    let yingYang = YingYang(frame: .zero)
    let yingYang2 = YingYang(frame: .zero)
    let circle3 = Circle(frame: .zero)
    let arc = Arc(frame: .zero)
    
    
    func setup(mainView : UIView, rect : CGRect, duration : Double = 5) -> UIView{

        let centerOfView = rect.center
        let n = min(rect.height, rect.width)
        
        circle3.center = CGPoint(x: centerOfView.x, y: centerOfView.y)
        circle3.bounds = CGRect(x: centerOfView.x, y: centerOfView.y, width: n, height: n)
        circle3.backgroundColor = .clear

        arc.center = CGPoint(x: circle3.center.x + n/2, y: circle3.center.y + n/2)
        arc.bounds = CGRect(x: arc.center.x, y: arc.center.y, width: n, height: n)
        arc.backgroundColor = .clear
        
        circle3.addSubview(arc)
        
        circle3.addSubview(yingYang.setup(mainView: circle3, rect: CGRect(x: circle3.center.x, y: circle3.center.y + n/4, width: n/2, height: n/2), duration: duration))
        circle3.addSubview(yingYang2.setup(mainView: circle3, rect: CGRect(x: circle3.center.x + n/2, y: circle3.center.y + n/4, width: n/2, height: n/2), duration: duration))
        
        
        rotateView(duration: duration)
        
        return circle3
    }

    func rotateView(duration: Double) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
            self.circle3.transform = self.circle3.transform.rotated(by: .pi)

        }) { (_) -> Void in
            self.rotateView(duration: duration)
        }
    }
}

class YingYangBiggest: UIView{
    
    let yingYang = YingYangBigger(frame: .zero)
    let yingYang2 = YingYangBigger(frame: .zero)
    let circle3 = Circle(frame: .zero)
    let arc = Arc(frame: .zero)

    func setup(mainView : UIView, rect : CGRect, duration : Double = 7) -> UIView{

        let centerOfView = rect.center
        let n = min(rect.height, rect.width)
        
        circle3.center = CGPoint(x: centerOfView.x, y: centerOfView.y)
        circle3.bounds = CGRect(x: centerOfView.x, y: centerOfView.y, width: n, height: n)
        circle3.backgroundColor = .clear

        arc.center = CGPoint(x: circle3.center.x + n/2, y: circle3.center.y + n/2)
        arc.bounds = CGRect(x: arc.center.x, y: arc.center.y, width: n, height: n)
        arc.backgroundColor = .clear
        
        circle3.addSubview(arc)
        
        circle3.addSubview(yingYang.setup(mainView: circle3, rect: CGRect(x: circle3.center.x, y: circle3.center.y + n/4, width: n/2, height: n/2), duration: duration))
        circle3.addSubview(yingYang2.setup(mainView: circle3, rect: CGRect(x: circle3.center.x + n/2, y: circle3.center.y + n/4, width: n/2, height: n/2), duration: duration))
        
        
        rotateView(duration: duration)
        
        return circle3
    }

    func rotateView(duration : Double) {
        UIView.animate(withDuration: duration, delay: 0, options: .curveLinear, animations: { () -> Void in
            self.circle3.transform = self.circle3.transform.rotated(by: .pi)

        }) { (_) -> Void in
            self.rotateView(duration: duration)
        }
    }
}
