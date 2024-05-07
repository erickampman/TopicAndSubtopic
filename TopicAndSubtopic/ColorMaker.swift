//
//  ColorMaker.swift
//  TopicAndSubtopic
//
//  Created by Eric Kampman on 5/7/24.
//

import Foundation
import SwiftUI


enum ColorMaker {
	
	static public var secondaryLabelColor: Color {
#if os(iOS)
		Color(uiColor: .secondaryLabelColor)
#elseif os(macOS)
		Color(nsColor: .secondaryLabelColor)
#endif
	}
	
	static public var tertiaryLabelColor: Color {
#if os(iOS)
		Color(uiColor: .tertiaryLabelColor)
#elseif os(macOS)
		Color(nsColor: .tertiaryLabelColor)
#endif
	}
	
	static public var textBackgroundColor: Color {
#if os(iOS)
		Color(uiColor: .textBackgroundColor)
#elseif os(macOS)
		Color(nsColor: .textBackgroundColor)
#endif
	}
}
