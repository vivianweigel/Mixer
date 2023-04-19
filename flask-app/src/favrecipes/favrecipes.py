from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


favrecipes = Blueprint('favrecipes', __name__)

# Gets all the top recipes with rating of 5 from database 
@favrecipes.route('/toprecipes', methods=['GET'])
def get_top():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of top recipes
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

# Gets all the users favorited recipes in the database
@favrecipes.route('/userfaves', methods=['GET'])
def get_userfaves():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    #getting data
    the_data = request.json
    user_id = str(the_data)

    # use cursor to query the database for a list of favorite recipes
    # TRY TO USE A USER_ID THAT THE USER INPUTS
    query = 'SELECT r.recipe_name, recipe_author, category, avg_rating, skill_level, r.recipe_id, steps FROM Favorite_recipes f join Users_fav_rec u on f.recipe_id = u.recipe_id join Recipes r on r.recipe_id = u.recipe_id WHERE user_id = '
    query += user_id
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

# Posts recipe
@favrecipes.route('/post_review', methods=['POST'])
def post_review():
    #getting data
    the_data = request.json
    current_app.logger.info(the_data)

    recipe_id = the_data[0]["recipe_id"]
    rating = the_data[1]
    comment = the_data[2]
    user_id = the_data[3]

    #writing query 
    query = 'insert into Recipe_review(recipe_id, rating, r_comment, user_id) values ("'
    query += str(recipe_id) + '", "'
    query += str(rating) + '", "'
    query += comment + '", "'
    query += str(user_id) + '")'

    #executing query
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success'

# Deletes rating 
@favrecipes.route('/delete_rating', methods=['DELETE'])
def delete_rating():
    #getting data
    the_data = request.json
    current_app.logger.info(the_data)

    recipe_id = the_data['recipe_id']
    user_id = the_data['user_id']
    cursor = db.get_db().cursor()

    #writing query
    query = 'DELETE FROM Recipe_review WHERE recipe_id = "'
    query += str(recipe_id)
    query += '" AND user_id = "'
    query += str(user_id) + '"'
    
    #executing query
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Success'


# put request to update average rating when new ratings are added 
@favrecipes.route('/update_rating', methods=['PUT'])
def update_rating():
    #getting data
    the_data = request.json
    current_app.logger.info(the_data)

    recipe_id = the_data['recipe_id']
    cursor = db.get_db().cursor()

    # Get the current rating and number of ratings for the recipe
    query = 'UPDATE Recipes SET avg_rating = (SElECT AVG(rating) FROM Recipe_review GROUP BY recipe_id HAVING recipe_id = '
    query += str(recipe_id) + ') WHERE recipe_id = '
    query += str(recipe_id) 

    cursor.execute(query)

    db.get_db().commit()

    return 'Success'

# Adds recipe to favorites 
@favrecipes.route('/add_to_fav', methods = ['POST'])
def add_to_fav():
    #getting data
    the_data = request.json
    current_app.logger.info(the_data)

    recipe_id = the_data[0]['recipe_id']
    user_id = the_data[1]
    #writing query
    query2 = 'insert into Users_fav_rec(recipe_id, user_id) values ("'
    query2 += str(recipe_id) + '", "'
    query2 += str(user_id) + '")'
    #executing query
    current_app.logger.info(query2)
    cursor = db.get_db().cursor()
    cursor.execute(query2)
    db.get_db().commit()
    
    return str(recipe_id) + ' ' + str(user_id)

# Gets all recipe stats in the database 
@favrecipes.route('/view_rec_stats', methods = ['GET'])
def view_rec_stats():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    the_data = request.json
    recipe_id = the_data['recipe_id']

    query = 'SELECT * FROM Recipe_review WHERE recipe_id = '
    query += str(recipe_id)
    # use cursor to query the database for a list of stats
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

# Gets your rating from the database
@favrecipes.route('/get_my_ratings', methods = ['GET'])
def get_my_rating():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # getting data
    the_data = request.json

    query = 'SELECT * FROM Recipe_review WHERE user_id = '
    query += str(the_data)
    # use cursor to query the database for a list of ratings
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