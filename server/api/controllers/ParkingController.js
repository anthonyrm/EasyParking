/**
 * ParkingController
 *
 * @description :: Server-side logic for managing parkings
 * @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 */

module.exports = {
	index: function (req, res) {
	  Parking.query('CALL GET_PARKINGS', function(err, results) {
	    if (err) return res.serverError(err);
	    return res.json(results[0]);
	  });
	}
};
