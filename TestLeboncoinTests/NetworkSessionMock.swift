//
//  NetworkSessionMock.swift
//  TestLeboncoinTests
//
//  Created by Stimlog on 08/10/2020.
//
import XCTest
@testable import TestLeboncoin

class NetworkSessionMock: NetworkSession {
    var data: Data?
    var error: Error?

    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data, error)
    }
}
