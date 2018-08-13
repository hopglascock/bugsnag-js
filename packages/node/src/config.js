const { schema } = require('@bugsnag/core/config')
const { reduce } = require('@bugsnag/core/lib/es-utils')
const { stringWithLength } = require('@bugsnag/core/lib/validators')
const os = require('os')
const process = require('process')

module.exports = {
  projectRoot: {
    defaultValue: () => process.cwd(),
    validate: value => value === null || stringWithLength(value),
    message: 'should be string'
  },
  hostname: {
    defaultValue: () => os.hostname(),
    message: 'should be a string',
    validate: value => value === null || stringWithLength(value)
  },
  logger: {
    ...schema.logger,
    defaultValue: () => getPrefixedConsole()
  },
  onUnhandledError: {
    defaultValue: () => (err, report, logger) => {
      const context = report.request
        ? ` at ${report.request.httpMethod} ${report.request.path || report.request.url}`
        : ``
      logger.error(`Encountered an unhandled error${context}, terminating…\n${err ? err.stack : err}`)
      process.exit(1)
    },
    message: 'should be a function',
    validate: value => typeof value === 'function'
  }
}

const getPrefixedConsole = () => {
  return reduce([ 'debug', 'info', 'warn', 'error' ], (accum, method) => {
    const consoleMethod = console[method] || console.log
    accum[method] = consoleMethod.bind(console, '[bugsnag]')
    return accum
  }, {})
}
