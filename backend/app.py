
from flask import Flask, request, jsonify, render_template_string
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///customers.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

class Customer(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(120))
    age = db.Column(db.Integer)
    email = db.Column(db.String(120), unique=True)

    def to_dict(self):
        return {
            'id': self.id,
            'name': self.name,
            'age': self.age,
            'email': self.email
        }

@app.before_request
def create_tables():
    db.create_all()

@app.route('/customers', methods=['GET'])
def get_customers():
    customers = Customer.query.all()
    return jsonify([c.to_dict() for c in customers])

@app.route('/customers', methods=['POST'])
def add_customer():
    data = request.json
    customer = Customer(name=data['name'], age=data['age'], email=data['email'])
    db.session.add(customer)
    db.session.commit()
    return jsonify(customer.to_dict()), 201

@app.route('/customers/<int:id>', methods=['DELETE'])
def delete_customer(id):
    customer = Customer.query.get(id)
    if not customer:
        return jsonify({'error': 'Customer not found'}), 404
    db.session.delete(customer)
    db.session.commit()
    return jsonify({'message': 'Customer deleted'}), 200

@app.route('/customers/view', methods=['GET'])
def view_customers():
    customers = Customer.query.all()
    html = '''
    <html>
        <head>
            <title>Customer List</title>
            <style>
                table { border-collapse: collapse; width: 80%%; margin: 20px auto; }
                th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
                th { background-color: #f2f2f2; }
                body { font-family: Arial, sans-serif; }
            </style>
        </head>
        <body>
            <h2 style="text-align: center;">Live Customer Database</h2>
            <table>
                <tr><th>ID</th><th>Name</th><th>Age</th><th>Email</th></tr>
                {% for c in customers %}
                <tr>
                    <td>{{ c.id }}</td>
                    <td>{{ c.name }}</td>
                    <td>{{ c.age }}</td>
                    <td>{{ c.email }}</td>
                </tr>
                {% endfor %}
            </table>
        </body>
    </html>
    '''
    return render_template_string(html, customers=customers)

if __name__ == '__main__':
    app.run(debug=True)
