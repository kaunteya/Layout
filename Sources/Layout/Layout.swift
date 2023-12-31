//
//  Layout.swift
//
//  Created by Kauntey Suryawanshi on 12/04/21.
//

import AppKit

public class Layout {
    private let v: NSView
        // OtherView is nil because size constraints dont need it
    private let otherView: NSView?
    public init(_ v: NSView, _ otherView: NSView? = nil) {
        self.v = v
        self.v.translatesAutoresizingMaskIntoConstraints = false
        self.otherView = otherView ?? v.superview
    }

    var constraints = [NSLayoutConstraint]()
    @discardableResult public func top(_ i: CGFloat = 0) -> Self {
        constraints.append(v.topAnchor.constraint(equalTo: otherView!.topAnchor, constant: i))
        return self
    }

    @discardableResult public func right(_ i: CGFloat = 0) -> Self {
        constraints.append(v.rightAnchor.constraint(equalTo: otherView!.rightAnchor, constant: i))
        return self
    }

    @discardableResult public func bottom(_ i: CGFloat = 0) -> Self {
        constraints.append(v.bottomAnchor.constraint(equalTo: otherView!.bottomAnchor, constant: i))
        return self
    }

    @discardableResult public func bottomSafeArea(_ i: CGFloat = 0) -> Self {
        constraints.append(v.bottomAnchor.constraint(equalTo: otherView!.layoutMarginsGuide.bottomAnchor, constant: i))
        return self
    }

    @discardableResult public func left(_ i: CGFloat = 0) -> Self {
        constraints.append(v.leftAnchor.constraint(equalTo: otherView!.leftAnchor, constant: i))
        return self
    }

    @discardableResult public func trailing(_ i: CGFloat = 0) -> Self {
        constraints.append(v.trailingAnchor.constraint(equalTo: otherView!.trailingAnchor, constant: i))
        return self
    }

    @discardableResult public func leading(_ i: CGFloat = 0) -> Self {
        constraints.append(v.leadingAnchor.constraint(equalTo: otherView!.leadingAnchor, constant: i))
        return self
    }

    @discardableResult public func width(_ i: CGFloat = 0) -> Self {
        constraints.append(v.widthAnchor.constraint(equalToConstant: i))
        return self
    }

    @discardableResult public func centerX(_ i: CGFloat = 0) -> Self {
        constraints.append(v.centerXAnchor.constraint(equalTo: otherView!.centerXAnchor, constant: i))
        return self
    }

    @discardableResult public func centerY(_ i: CGFloat = 0) -> Self {
        constraints.append(v.centerYAnchor.constraint(equalTo: otherView!.centerYAnchor, constant: i))
        return self
    }

    @discardableResult public func center() -> Self {
        self.centerX(0).centerY(0)
    }

    @discardableResult public func height(_ i: CGFloat) -> Self {
        constraints.append(v.heightAnchor.constraint(equalToConstant: i))
        return self
    }

    @discardableResult public func size(_ i: CGFloat) -> Self {
        self.width(i).height(i)
        return self
    }

        /// Adds self.left(i).right(-i)
    @discardableResult public func horizontal(_ i: CGFloat = 0) -> Self {
        self.left(i).right(-i)
    }

        /// Adds self.top(i).bottom(-i)
    @discardableResult public func vertical(_ i: CGFloat = 0) -> Self {
        self.top(i).bottom(-i)
    }

        /// Other view can be superview
    @discardableResult public func equalViews(_ i: CGFloat = 0) -> Self {
        self.top(i).right(-i).bottom(-i).left(i)
    }
}

extension NSView {
    public func applyConstraints(layout: Layout) {
        assert(translatesAutoresizingMaskIntoConstraints == false)
        NSLayoutConstraint.activate(layout.constraints)
    }

    public func applyConstraints(layout: (Layout) -> Layout) {
        applyConstraints(layout: layout(Layout(self)))
    }

    public func addSubview(_ v: NSView, layout: (Layout) -> Layout) {
        addSubview(v)
        let edges = layout(Layout(v))
        NSLayoutConstraint.activate(edges.constraints)
    }

    public func addSubview(_ v: NSView, handler: () -> Layout) {
        addSubview(v)
        let edges = handler()
        NSLayoutConstraint.activate(edges.constraints)
    }
}
