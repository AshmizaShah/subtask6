// test/test.js
const chai = require('chai');
const chaiHttp = require('chai-http');
const should = chai.should();

chai.use(chaiHttp);

describe('GET /', () => {
    it('it should GET the home page', (done) => {
        chai.request('http://localhost:4200')
            .get('/')
            .end((err, res) => {
                res.should.have.status(200);
                res.text.should.be.eql('Hello World!');
                done();
            });
    });
});
