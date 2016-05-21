/**
 * UserController
 *
 * @description :: Server-side logic for managing users
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
	index: function (req, res) {
  User.query('CALL GET_USERS', function(err, results) {
      if (err) return res.serverError(err);
      return res.json(results[0]);
		});

  }

};
