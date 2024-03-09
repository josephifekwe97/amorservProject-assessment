const chai = require('chai');
const chaiHttp = require('chai-http');
//const server = require('../server');

chai.use(chaiHttp);
chai.should();

describe('Users', () => {
  describe('GET /api/users', () => {
    it('it should GET all the users', (done) => {
      chai.request(server)
        .get('/api/users')
        .end((err, res) => {
          res.should.have.status(200);
          res.body.should.be.a('array');
          done();
        });
    });
  });

  describe('POST /api/users', () => {
    it('it should create a new user', (done) => {
      const newUser = { name: 'Test User' };
      chai.request(server)
        .post('/api/users')
        .send(newUser)
        .end((err, res) => {
          res.should.have.status(201);
          res.body.should.be.a('object');
          res.body.should.have.property('id');
          res.body.should.have.property('name').eql(newUser.name);
          done();
        });
    });
  });
});
