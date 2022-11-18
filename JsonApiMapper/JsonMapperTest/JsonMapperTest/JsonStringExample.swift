//
//  JsonStringExample.swift
//  JsonMapperTest
//
//  Created by Taher on 15/11/22.
//

import Foundation

final class JsonStringCollection {

    static func getSurveyString() -> String {
        return
"""
{
  "data": [
    {
      "id": "d5de6a8f8f5f1cfe51bc",
      "type": "survey",
      "attributes": {
        "title": "Scarlett Bangkok",
        "is_active": true
      },
      "relationships": {
        "questions": {
          "data": [
            {
              "id": "d3afbcf2b1d60af845dc",
              "type": "question"
            },
            {
              "id": "940d229e4cd87cd1e202",
              "type": "question"
            }
          ]
        }
      }
    },
    {
      "id": "ed1d4f0ff19a56073a14",
      "type": "survey",
      "attributes": {
        "title": "ibis Bangkok Riverside",
        "is_active": true
      },
      "relationships": {
        "questions": {
          "data": [
            {
              "id": "fa385b75617d98e069a3",
              "type": "question"
            },
            {
              "id": "1b03688d4af8a5c6b1e0",
              "type": "question"
            }
          ]
        }
      }
    }
  ],
  "meta": {
    "page": 1,
    "pages": 10,
    "page_size": 2,
    "records": 20
  }
}
"""
    }
}
