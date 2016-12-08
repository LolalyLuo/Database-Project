#Import Flask Library
import hashlib
import datetime
from flask import Flask, render_template, request, session, url_for, redirect
import pymysql.cursors

#Initialize the app from Flask
app = Flask(__name__)

#Configure MySQL
conn = pymysql.connect(host='localhost',
                       user='root',
                       password='',
                       db='meetup3',
                       charset='utf8mb4',
                       cursorclass=pymysql.cursors.DictCursor)

#Define a route to hello function
@app.route('/')
def hello():
        cursor = conn.cursor();
        today = datetime.date.today()
        query = 'SELECT event_id, title, start_time, location_name, zipcode FROM an_event WHERE start_time>= %s AND start_time < DATE(DATE_ADD(%s, INTERVAL 3 DAY))'
        cursor.execute(query, (today, today))
        event_data = cursor.fetchall()

        query = 'SELECT category, keyword FROM interest'
        cursor.execute(query)
        interest_data = cursor.fetchall()
	
        cursor.close()
        return render_template('index.html', event_info = event_data, interest_info = interest_data)

#Define route for find group interest search
@app.route('/group_interest_search', methods=['GET', 'POST'])
def group_interest_search():
        cursor = conn.cursor();
        category = request.form['category']
        keyword = request.form['keyword']
        query = 'SELECT a_group.group_id, group_name, description, creator FROM about NATURAL JOIN a_group WHERE category = %s and keyword = %s'
        cursor.execute(query,(category, keyword))
        conn.commit()
        cursor.close()
        return redirect(url_for('index'))

#Define route for login
@app.route('/login')
def login():
	return render_template('login.html')

#Define route for register
@app.route('/register')
def register():
	return render_template('register.html')

#Authenticates the login
@app.route('/loginAuth', methods=['GET', 'POST'])
def loginAuth():
	#grabs information from the forms
	username = request.form['username']
	password = request.form['password']

	#cursor used to send queries
	cursor = conn.cursor()
	#executes query
	h = hashlib.md5()
	h.update(password.encode('utf-8'))
	query = 'SELECT * FROM member WHERE username = %s and password = %s'
	cursor.execute(query, (username, h.hexdigest()))
	#stores the results in a variable
	data = cursor.fetchone()
	#use fetchall() if you are expecting more than 1 data row
	cursor.close()
	error = None
	if(data):
		#creates a session for the the user
		#session is a built in
		session['username'] = username
		return redirect(url_for('home'))
	else:
		#returns an error message to the html page
		error = 'Invalid login or username'
		return render_template('login.html', error=error)

#Authenticates the register
@app.route('/registerAuth', methods=['GET', 'POST'])
def registerAuth():
	#grabs information from the forms
	username = request.form['username']
	password = request.form['password']

	#cursor used to send queries
	cursor = conn.cursor()
	#executes query
	query = 'SELECT * FROM user WHERE username = %s'
	cursor.execute(query, (username))
	#stores the results in a variable
	data = cursor.fetchone()
	#use fetchall() if you are expecting more than 1 data row
	error = None
	if(data):
		#If the previous query returns data, then user exists
		error = "This user already exists"
		return render_template('register.html', error = error)
	else:
		ins = 'INSERT INTO user VALUES(%s, %s)'
		cursor.execute(ins, (username, password))
		conn.commit()
		cursor.close()
		return render_template('index.html')

@app.route('/home')
def home():
	username = session['username']
	cursor = conn.cursor();
	query = 'SELECT group_name FROM a_group NATURAL JOIN belongs_to WHERE username = %s'
	cursor.execute(query, (username))
	group_data = cursor.fetchall()
	
	today = datetime.date.today()
	query = 'SELECT event_id, title, start_time, location_name, zipcode FROM an_event NATURAL JOIN sign_up WHERE username = %s AND start_time>= %s AND start_time < DATE(DATE_ADD(%s, INTERVAL 3 DAY))'
	cursor.execute(query, (username, today, today))
	event_data = cursor.fetchall()
	
	query = 'SELECT an_event.event_id, title, an_event.description, start_time, end_time, location_name, an_event.zipcode FROM interested_in NATURAL JOIN about, member, a_group, an_event, organize WHERE interested_in.username = member.username AND a_group.group_id = about.group_id AND a_group.group_id = organize.group_id AND an_event.event_id = organize.event_id AND member.username = %s'
	cursor.execute(query, (username))
	int_event_data = cursor.fetchall()
	cursor.close()

	return render_template('home.html', username=username, group_info=group_data, event_info = event_data, int_event_info = int_event_data)

		
@app.route('/sign_up', methods=['GET', 'POST'])
def sign_up():
	username = session['username']
	cursor = conn.cursor();
	event_id = request.form['event_id']
	query = 'INSERT INTO sign_up (event_id, username, rating) VALUES(%s, %s,0)'
	cursor.execute(query, (event_id, username))
	conn.commit()
	cursor.close()
	#need to give error message 
	return redirect(url_for('home'))

@app.route('/logout')
def logout():
	session.pop('username')
	return redirect('/')
		
app.secret_key = 'some key that you will never guess'
#Run the app on localhost port 5000
#debug = True -> you don't have to restart flask
#for changes to go through, TURN OFF FOR PRODUCTION
if __name__ == "__main__":
	app.run('127.0.0.1', 5000, debug = True)
