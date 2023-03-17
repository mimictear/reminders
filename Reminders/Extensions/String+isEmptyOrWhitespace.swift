//
//  String+isEmptyOrWhitespace.swift
//  Reminders
//
//  Created by ANDREY VORONTSOV on 14.03.2023.
//

extension String {
    var isEmptyOrWhitespace: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
