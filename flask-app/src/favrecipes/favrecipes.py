from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


favrecipes = Blueprint('favrecipes', __name__)

@favrecipes.route('/toprecipes', methods=['GET'])
def get_top():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT * FROM Recipes WHERE avg_rating > 4')

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


@favrecipes.route('/userfaves', methods=['GET'])
def get_userfaves():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    # TRY TO USE A USER_ID THAT THE USER INPUTS
    cursor.execute('SELECT r.recipe_name, recipe_author, category, avg_rating, skill_level, steps FROM Favorite_recipes f join Users_fav_rec u on f.recipe_id = u.recipe_id join Recipes r on r.recipe_id = u.recipe_id WHERE user_id = 144')

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


@favrecipes.route('/post_review', methods=['POST'])
def post_review():
    the_data = request.json
    current_app.logger.info(the_data)

    # photo = the_data[''] ???
    rating = the_data['rating']
    comment = the_data['r_comment']

    query = 'insert into Recipe_review(rating, r_comment) values ('
    query += str(rating) + '", "'
    query += comment + ')'

    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Sucess'


@favrecipes.route('/post_comment', methods=['POST'])
def post_comment():
    the_data = request.json
    current_app.logger.info(the_data)

    comment = the_data['r_comment']

    query = 'insert into Recipe_review(r_comment) values ("'
    query += comment + ')'

    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Sucess'


@favrecipes.route('/post_rating', methods=['POST'])
def post_rating():
    the_data = request.json
    current_app.logger.info(the_data)

    rating = the_data['rating']
    recipe_id = the_data['recipe_id']

    query = 'INSERT INTO Recipe_review(recipe_id, rating) VALUES ('
    query += recipe_id + '","'
    query += rating + ')'

    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success'


# put request to update average rating when new ratings are added ???

@favrecipes.route('/update_rating/<int:recipe_id>', methods=['PUT'])
def update_rating(recipe_id):
    the_data = request.json
    current_app.logger.info(the_data)

    new_rating = the_data['new_rating']
    cursor = db.get_db().cursor()

    # Get the current rating and number of ratings for the recipe
    cursor.execute('SELECT AVG(rating), COUNT(*) FROM Recipe_review WHERE recipe_id = %s', (recipe_id,))
    result = cursor.fetchone()
    current_rating = result[0]
    num_ratings = result[1]

    # Calculate the new average rating
    if num_ratings == 0:
        new_avg_rating = new_rating
    else:
        new_avg_rating = (current_rating * num_ratings + new_rating) / (num_ratings + 1)

    # Update the rating in the database
    cursor.execute('UPDATE Recipe SET rating = %s WHERE recipe_id = %s', (new_avg_rating, recipe_id))
    db.get_db().commit()

    return 'Success'


# how to go about unfavoriting a recipe ???

# work on this
@favrecipes.route('/delete_rating', methods=['DELETE'])
def delete_rating():
    query = 'DELETE FROM Recipe_review WHERE id = %s'
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Success'

@favrecipes.route('/add_to_fav', methods = ['POST'])
def add_to_fav():
    the_data = request.json
    current_app.logger.info(the_data)

    recipe_id = the_data['recipe_id']
    user_id = 6

    query2 = 'insert into Users_fav_rec(recipe_id, user_id) values ("'
    query2 += str(recipe_id) + '", "'
    query2 += str(user_id) + '")'

    current_app.logger.info(query2)
    cursor = db.get_db().cursor()
    cursor.execute(query2)
    db.get_db().commit()
    
    return 'Sucess'

@favrecipes.route('/view_rec_stats', methods = ['GET'])
def view_rec_stats():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    the_data = request.json
    recipe_id = the_data['recipe_id']

    query = 'SELECT * FROM Recipe_review WHERE recipe_id = '
    query += str(recipe_id)
    # use cursor to query the database for a list of products
    cursor.execute(query)

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


# # Get all customers from the DB
# @favrecipes.route('/favrecipes', methods=['GET'])
# def get_customers():
#     cursor = db.get_db().cursor()
#     cursor.execute('select company, last_name,\
#         first_name, job_title, business_phone from customers')
#     row_headers = [x[0] for x in cursor.description]
#     json_data = []
#     theData = cursor.fetchall()
#     for row in theData:
#         json_data.append(dict(zip(row_headers, row)))
#     the_response = make_response(jsonify(json_data))
#     the_response.status_code = 200
#     the_response.mimetype = 'application/json'
#     return the_response

# # Get customer detail for customer with particular userID
# @favrecipes.route('/favrecipes/<userID>', methods=['GET'])
# def get_customer(userID):
#     cursor = db.get_db().cursor()
#     cursor.execute('select * from customers where id = {0}'.format(userID))
#     row_headers = [x[0] for x in cursor.description]
#     json_data = []
#     theData = cursor.fetchall()
#     for row in theData:
#         json_data.append(dict(zip(row_headers, row)))
#     the_response = make_response(jsonify(json_data))
#     the_response.status_code = 200
#     the_response.mimetype = 'application/json'
#     return the_response