/**
 * LoginController
 *
 * @description :: Server-side logic for managing logins
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
	getInfo: function (req, res) {
	Parking.query("CALL LOGIN_USER('" + req.query.name +  "','" + req.query.pass + "')", function(err, results) {
		if (err) return res.serverError(err);
		return res.json(results[0]);
			});
},

};
