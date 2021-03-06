// magical jasmine globals
const { describe, it, expect } = global

const transport = require('../../transports/xml-http-request')

if (!('XDomainRequest' in window)) {
  describe('transport:XMLHttpRequest', () => {
    it('sends reports successfully', done => {
      const payload = { sample: 'payload' }
      transport.sendReport({}, { endpoints: { notify: '/echo/' } }, payload, (err, responseText) => {
        expect(err).toBe(null)
        expect(responseText).toBe(JSON.stringify(payload))
        done()
      })
    })
    it('sends sessions successfully', done => {
      const payload = { sample: 'payload' }
      transport.sendSession({}, { endpoints: { notify: '/', sessions: '/echo/' } }, payload, (err, responseText) => {
        expect(err).toBe(null)
        expect(responseText).toBe(JSON.stringify(payload))
        done()
      })
    })
  })
}
