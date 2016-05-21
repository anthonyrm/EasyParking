/**
 * User.js
 *
 * @description :: TODO: You might write a short summary of how this model works and what it represents here.
 * @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models
 */

module.exports = {

  attributes: {
    IdUser:{
      type:'int'
    },
    UserName:{
      type:'string',
      required:true
    },
    UserApellido:{
      type:'string'
    },
    UserLicenceplate:{
      type:'string'

    },
    Contraseña:{
      type:'string',
      required:true
    }

  }
};
