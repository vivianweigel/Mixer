from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


myrecipes = Blueprint('myrecipes', __name__)

# Get all the products from the database
@myrecipes.route('/recipes', methods=['GET'])
def get_recipes():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT * FROM Recipes')

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


# Get all the products from the database
@myrecipes.route('/nutritional_info', methods=['GET'])
def get_nutritional_info():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    the_data = request.json
    ingredient_name = the_data['ingredient_name']

    query = 'SELECT * FROM Nutritional_info WHERE ingredient_name = "'
    query += str(ingredient_name) + '"'
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
 
# Get all the products from the database
@myrecipes.route('/ingredients', methods=['GET'])
def get_ingredients():
     # get a cursor object from the database
    cursor = db.get_db().cursor()

    the_data = request.json
    recipe_id = the_data['recipe_id']

    query = 'SELECT * FROM Ingredients WHERE recipe_id = '
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

# Get all the products from the database
@myrecipes.route('/personal_recipes', methods=['GET'])
def get_mine():

    cursor = db.get_db().cursor()

    the_data = request.json
    user_id = str(the_data)

    # use cursor to query the database for a list of products
    # TRY TO USE A USER_ID THAT THE USER INPUTS
    query = 'SELECT recipe_name FROM Personal_recipes WHERE user_id = "'
    query += user_id + '"'
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



# post a new recipe to personal recipes
@myrecipes.route('/post_recipe', methods=['POST'])
def post_recipe():
    the_data = request.json
    current_app.logger.info(the_data)
    row = the_data[0]

    # getting data
    name = row['recipe_name']
    skill_level = row['skill_level']
    steps = row['steps']
    category = row['category']

    # writing query to insert data into recipes
    query = 'insert into Recipes(recipe_name, skill_level, steps, category) values ("'
    query += name + '", "'
    query += skill_level + '", "'
    query += steps + '", "'
    query += category + '")'

    # executing query
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)

    # write a query to get rec id
    query3 = 'SELECT recipe_id FROM Recipes WHERE recipe_name = "'
    query3 += name + '"'
    rec_id = cursor.execute(query3)

    # writing query to add recipe to their personal recipes
    query2 = 'insert into Personal_recipes(recipe_name, user_id, recipe_id) values ("'
    query2 += name + '", "'
    query2 += str(the_data[1]) + '", "'
    query2 += str(rec_id) + '")'
    cursor.execute(query2)
    current_app.logger.info(query)
    db.get_db().commit()
    
    return 'Success'


@myrecipes.route('/update_name', methods=['PUT'])
def update_amount():
    the_data = request.json
    current_app.logger.info(the_data)

    user_id = the_data[0]
    new_name = the_data[1]
    curr_name = the_data[2]['recipe_name']
    cursor = db.get_db().cursor()

    # Get the current rating and number of ratings for the recipe
    query = 'UPDATE Personal_recipes SET recipe_name = "'
    query += new_name + '" WHERE recipe_name = "'
    query += curr_name + '" AND user_id = '
    query += str(user_id)

    cursor.execute(query)

    db.get_db().commit()

    return 'Success'

@myrecipes.route('/delete_recipe', methods=['DELETE'])
def delete_recipe():

    the_data = request.json
    current_app.logger.info(the_data)

    user_id = the_data[0]
    name = the_data[1]['recipe_name']
    cursor = db.get_db().cursor()

    query = 'DELETE FROM Personal_recipes WHERE user_id = '
    query += str(user_id)
    query += ' AND recipe_name = "'
    query += str(name) + '"'
    
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Success'

# filter for category
@myrecipes.route('/get_category', methods=['GET'])
def get_category():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # getting data
    the_data = request.json

    # creating query
    query = 'SELECT * FROM Recipes WHERE category = "'
    query += the_data + '"'

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