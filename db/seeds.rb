# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Application.create

GlobalData.create(isConnected: false, Username: 'toto', Email: '@', role: 0, reset: false, recruiter_id: 1)
Enterprise.create name:'Google'
Recruiter.create name:'Recruiter 1', enterprise_id:1
Offer.create title:"testOffer", recruiter_id:1
