/**
 * Spot.js
 *
 * @description :: TODO: You might write a short summary of how this model works and what it represents here.
 * @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models
 */

module.exports = {

  attributes: {
    Id: {type: 'int'},
    IdUbication: {type: 'int'},
    State: {type: 'string'},
    Level: {type: 'string'},
    UbicationNumber: {type: 'string'},
    IdParking: {type: 'int'},
    IdState: {type: 'int'}
  }
};
