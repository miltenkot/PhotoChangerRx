import UIKit
import RxSwift
import RxCocoa


let disposedBag = DisposeBag()

let relay = BehaviorRelay(value: [String]())


var p = relay.value
p.append("item 1")

relay.accept(p)

relay.asObservable().subscribe {
    print($0)
}

 








