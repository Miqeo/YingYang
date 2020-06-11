# YingYang
Opensource Ying Yang Fractal animation

It's an easy to use and implement animation for swift 4/5 made with Bezier paths in UIKit.

# Usage
The example beneath shows how to implement three different sizes of yingyang.
```
let small = YingYang(frame: .zero)
let bigger = YingYangBigger(frame: .zero)
let biggest = YingYangBiggest(frame: .zero)
```
```
view.addSubview(small.setup(mainView: view, rect: CGRect(x: 100, y: 50, width: 200.0, height: 200.0), duration: 3))
view.addSubview(bigger.setup(mainView: view, rect: CGRect(x: 100, y: 300, width: 200.0, height: 200.0), duration: 5))
view.addSubview(biggest.setup(mainView: view, rect: CGRect(x: 100, y: 600, width: 200.0, height: 200.0), duration: 7))  
```

# Upcoming Updates - hopefully
- Changing colors
- Changing speed on the fly
