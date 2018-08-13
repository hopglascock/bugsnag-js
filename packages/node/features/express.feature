Feature: @bugsnag/plugin express

Background:
  Given I set environment variable "BUGSNAG_API_KEY" to "9c2151b65d615a3a95ba408142c8698f"
  And I configure the bugsnag notify endpoint

Scenario Outline: a synchronous thrown error in a route
  And I set environment variable "NODE_VERSION" to "<node version>"
  And I have built the service "express"
  And I start the service "express"
  And I wait for the app to respond on port "4312"
  Then I open the URL "http://localhost:4312/sync"
  And I wait for 2 seconds
  Then I should receive a request
  And the request used the Node notifier
  And the request used payload v4 headers
  And the "bugsnag-api-key" header equals "9c2151b65d615a3a95ba408142c8698f"
  And the event "unhandled" is true
  And the event "severity" equals "error"
  And the event "severityReason.type" equals "unhandledErrorMiddleware"
  And the exception "errorClass" equals "Error"
  And the exception "message" equals "sync"
  And the exception "type" equals "nodejs"
  And the "file" of stack frame 0 equals "scenarios/app.js"

  Examples:
  | node version |
  | 4            |
  | 6            |
  | 8            |

Scenario Outline: an asynchronous thrown error in a route
  And I set environment variable "NODE_VERSION" to "<node version>"
  And I have built the service "express"
  And I start the service "express"
  And I wait for the app to respond on port "4312"
  Then I open the URL "http://localhost:4312/async"
  And I wait for 2 seconds
  Then I should receive a request
  And the request used the Node notifier
  And the request used payload v4 headers
  And the "bugsnag-api-key" header equals "9c2151b65d615a3a95ba408142c8698f"
  And the event "unhandled" is true
  And the event "severity" equals "error"
  And the event "severityReason.type" equals "unhandledErrorMiddleware"
  And the exception "errorClass" equals "Error"
  And the exception "message" equals "async"
  And the exception "type" equals "nodejs"
  And the "file" of stack frame 0 equals "scenarios/app.js"

  Examples:
  | node version |
  | 4            |
  | 6            |
  | 8            |

Scenario Outline: an error passed to next(err)
  And I set environment variable "NODE_VERSION" to "<node version>"
  And I have built the service "express"
  And I start the service "express"
  And I wait for the app to respond on port "4312"
  Then I open the URL "http://localhost:4312/next"
  And I wait for 2 seconds
  Then I should receive a request
  And the request used the Node notifier
  And the request used payload v4 headers
  And the "bugsnag-api-key" header equals "9c2151b65d615a3a95ba408142c8698f"
  And the event "unhandled" is true
  And the event "severity" equals "error"
  And the event "severityReason.type" equals "unhandledErrorMiddleware"
  And the exception "errorClass" equals "Error"
  And the exception "message" equals "next"
  And the exception "type" equals "nodejs"
  And the "file" of stack frame 0 equals "scenarios/app.js"

  Examples:
  | node version |
  | 4            |
  | 6            |
  | 8            |

Scenario Outline: a synchronous promise rejection in a route
  And I set environment variable "NODE_VERSION" to "<node version>"
  And I have built the service "express"
  And I start the service "express"
  And I wait for the app to respond on port "4312"
  Then I open the URL "http://localhost:4312/rejection-sync"
  And I wait for 2 seconds
  Then I should receive a request
  And the request used the Node notifier
  And the request used payload v4 headers
  And the "bugsnag-api-key" header equals "9c2151b65d615a3a95ba408142c8698f"
  And the event "unhandled" is true
  And the event "severity" equals "error"
  And the event "severityReason.type" equals "unhandledErrorMiddleware"
  And the exception "errorClass" equals "Error"
  And the exception "message" equals "reject sync"
  And the exception "type" equals "nodejs"
  And the "file" of stack frame 0 equals "scenarios/app.js"

  Examples:
  | node version |
  | 4            |
  | 6            |
  | 8            |

Scenario Outline: an asynchronous promise rejection in a route
  And I set environment variable "NODE_VERSION" to "<node version>"
  And I have built the service "express"
  And I start the service "express"
  And I wait for the app to respond on port "4312"
  Then I open the URL "http://localhost:4312/rejection-async"
  And I wait for 2 seconds
  Then I should receive a request
  And the request used the Node notifier
  And the request used payload v4 headers
  And the "bugsnag-api-key" header equals "9c2151b65d615a3a95ba408142c8698f"
  And the event "unhandled" is true
  And the event "severity" equals "error"
  And the event "severityReason.type" equals "unhandledErrorMiddleware"
  And the exception "errorClass" equals "Error"
  And the exception "message" equals "reject async"
  And the exception "type" equals "nodejs"
  And the "file" of stack frame 0 equals "scenarios/app.js"

  Examples:
  | node version |
  | 4            |
  | 6            |
  | 8            |

Scenario Outline: a string passed to next(err)
  And I set environment variable "NODE_VERSION" to "<node version>"
  And I have built the service "express"
  And I start the service "express"
  And I wait for the app to respond on port "4312"
  Then I open the URL "http://localhost:4312/string-as-error"
  And I wait for 2 seconds
  Then I should receive a request
  And the request used the Node notifier
  And the request used payload v4 headers
  And the "bugsnag-api-key" header equals "9c2151b65d615a3a95ba408142c8698f"
  And the event "unhandled" is true
  And the event "severity" equals "error"
  And the event "severityReason.type" equals "unhandledErrorMiddleware"
  And the exception "errorClass" equals "Error"
  And the exception "message" matches "^Handled a non-error\."
  And the exception "type" equals "nodejs"
  And the "file" of stack frame 0 equals "node_modules/@bugsnag/plugin-express/dist/bugsnag-express.js"

  Examples:
  | node version |
  | 4            |
  | 6            |
  | 8            |

Scenario Outline: throwing non-Error error
  And I set environment variable "NODE_VERSION" to "<node version>"
  And I have built the service "express"
  And I start the service "express"
  And I wait for the app to respond on port "4312"
  Then I open the URL "http://localhost:4312/throw-non-error"
  And I wait for 2 seconds
  Then I should receive a request
  And the request used the Node notifier
  And the request used payload v4 headers
  And the "bugsnag-api-key" header equals "9c2151b65d615a3a95ba408142c8698f"
  And the event "unhandled" is true
  And the event "severity" equals "error"
  And the event "severityReason.type" equals "unhandledErrorMiddleware"
  And the exception "errorClass" equals "Error"
  And the exception "message" matches "^Handled a non-error\."
  And the exception "type" equals "nodejs"
  And the "file" of stack frame 0 equals "node_modules/@bugsnag/plugin-express/dist/bugsnag-express.js"

  Examples:
  | node version |
  | 4            |
  | 6            |
  | 8            |
