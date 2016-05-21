/**
 * SpotController
 *
 * @description :: Server-side logic for managing spots
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
	index: function (req, res) {
  	User.query('CALL GET_SPOTS_BYID(' + req.query.id + ')', function(err, results) {
      if (err) return res.serverError(err);
      return res.json(results[0]);
		});
	}
};
