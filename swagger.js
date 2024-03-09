const swaggerJsdoc = require('swagger-jsdoc');
const swaggerUi = require('swagger-ui-express');

const options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'User API',
      version: '1.0.0',
      description: 'A simple CRUD API for managing users',
    },
  },
  apis: ['./routes/*.js'],
};

const specs = swaggerJsdoc(options);

module.exports = (app) => {
  //app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(specs));
  app.use('/swagger', swaggerUi.serve, swaggerUi.setup(specs));
};
