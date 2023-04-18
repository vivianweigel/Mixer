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

    query = 'SELECT * FROM Nutritional_info WHERE ingredient_name = '
    query += str(ingredient_name)
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
    query = 'SELECT recipe_name FROM Personal_recipes WHERE user_id = '
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



# post a new recipe to personal recipes
@myrecipes.route('/post_recipe', methods=['POST'])
def post_recipe():
    the_data = request.json
    current_app.logger.info(the_data)

    name = the_data['recipe_name']
    skill_level = the_data['skill_level']
    steps = the_data['steps']
    category = the_data['category']

    query = 'insert into Recipes(recipe_name, skill_level, steps, category) values ("'
    query += name + '", "'
    query += skill_level + '", "'
    query += steps + '", "'
    query += category + '")'

    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success'


# # get the top 5 products from the database
# @products.route('/mostExpensive')
# def get_most_pop_products():
#     cursor = db.get_db().cursor()
#     query = '''
#         SELECT product_code, product_name, list_price, reorder_level
#         FROM products
#         ORDER BY list_price DESC
#         LIMIT 5
#     '''
#     cursor.execute(query)
#        # grab the column headers from the returned data
#     column_headers = [x[0] for x in cursor.description]

#     # create an empty dictionary object to use in 
#     # putting column headers together with data
#     json_data = []

#     # fetch all the data from the cursor
#     theData = cursor.fetchall()

#     # for each of the rows, zip the data elements together with
#     # the column headers. 
#     for row in theData:
#         json_data.append(dict(zip(column_headers, row)))

#     return jsonify(json_data)