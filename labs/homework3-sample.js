/**
 * You can submit your question start with "//" as the comment block comes before
 * your mongo script
 */

// 1. find all restaurants documents
db.restaurants.find();

// 2. update restaurant with name '1234' with new name '5678'
db.restaurants.update({'name': '1234'}, { $set: { 'name': '5678' } });
