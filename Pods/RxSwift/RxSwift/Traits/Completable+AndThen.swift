//
//  Completable+AndThen.swift
//  RxSwift
//
//  Created by Krunoslav Zaher on 7/2/17.
//  Copyright © 2017 Krunoslav Zaher. All rights reserved.
//

extension PrimitiveSequenceType where TraitType == CompletableTrait, ElementType == Never {
    /**
     Concatenates the second observable sequence to `self` upon successful termination of `self`.

     - seealso: [concat operator on reactivex.io](http://reactivex.io/documentation/operators/concat.html)

     - parameter second: Second observable sequence.
     - returns: An observable sequence that contains the elements of `self`, followed by those of the second sequence.
     */
    public func andThen<E>(_ second: Single<E>) -> Single<E> {
        let completable = primitiveSequence.asObservable()
        return Single(raw: ConcatCompletable(completable: completable, second: second.asObservable()))
    }

    /**
     Concatenates the second observable sequence to `self` upon successful termination of `self`.

     - seealso: [concat operator on reactivex.io](http://reactivex.io/documentation/operators/concat.html)

     - parameter second: Second observable sequence.
     - returns: An observable sequence that contains the elements of `self`, followed by those of the second sequence.
     */
    public func andThen<E>(_ second: Maybe<E>) -> Maybe<E> {
        let completable = primitiveSequence.asObservable()
        return Maybe(raw: ConcatCompletable(completable: completable, second: second.asObservable()))
    }

    /**
     Concatenates the second observable sequence to `self` upon successful termination of `self`.

     - seealso: [concat operator on reactivex.io](http://reactivex.io/documentation/operators/concat.html)

     - parameter second: Second observable sequence.
     - returns: An observable sequence that contains the elements of `self`, followed by those of the second sequence.
     */
    public func andThen(_ second: Completable) -> Completable {
        let completable = primitiveSequence.asObservable()
        return Completable(raw: ConcatCompletable(completable: completable, second: second.asObservable()))
    }

    /**
     Concatenates the second observable sequence to `self` upon successful termination of `self`.

     - seealso: [concat operator on reactivex.io](http://reactivex.io/documentation/operators/concat.html)

     - parameter second: Second observable sequence.
     - returns: An observable sequence that contains the elements of `self`, followed by those of the second sequence.
     */
    public func andThen<E>(_ second: Observable<E>) -> Observable<E> {
        let completable = primitiveSequence.asObservable()
        return ConcatCompletable(completable: completable, second: second.asObservable())
    }
}

fileprivate final class ConcatCompletable<Element>: Producer<Element> {
    fileprivate let _completable: Observable<Never>
    fileprivate let _second: Observable<Element>

    init(completable: Observable<Never>, second: Observable<Element>) {
        _completable = completable
        _second = second
    }

    override func run<O>(_ observer: O, cancel: Cancelable) -> (sink: Disposable, subscription: Disposable) where O: ObserverType, O.E == Element {
        let sink = ConcatCompletableSink(parent: self, observer: observer, cancel: cancel)
        let subscription = sink.run()
        return (sink: sink, subscription: subscription)
    }
}

fileprivate final class ConcatCompletableSink<O: ObserverType>
    : Sink<O>
    , ObserverType {
    typealias E = Never
    typealias Parent = ConcatCompletable<O.E>

    private let _parent: Parent
    private let _subscription = SerialDisposable()

    init(parent: Parent, observer: O, cancel: Cancelable) {
        _parent = parent
        super.init(observer: observer, cancel: cancel)
    }

    func on(_ event: Event<E>) {
        switch event {
        case let .error(error):
            forwardOn(.error(error))
            dispose()
        case .next:
            break
        case .completed:
            let otherSink = ConcatCompletableSinkOther(parent: self)
            _subscription.disposable = _parent._second.subscribe(otherSink)
        }
    }

    func run() -> Disposable {
        let subscription = SingleAssignmentDisposable()
        _subscription.disposable = subscription
        subscription.setDisposable(_parent._completable.subscribe(self))
        return _subscription
    }
}

fileprivate final class ConcatCompletableSinkOther<O: ObserverType>
    : ObserverType {
    typealias E = O.E

    typealias Parent = ConcatCompletableSink<O>

    private let _parent: Parent

    init(parent: Parent) {
        _parent = parent
    }

    func on(_ event: Event<O.E>) {
        _parent.forwardOn(event)
        if event.isStopEvent {
            _parent.dispose()
        }
    }
}
