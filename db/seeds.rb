# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



GlobalData.create(isConnected: false, Username: 'toto', Email: '@', role: 1, reset: false, user_id: 1, image: "")

skillsList = ["Android", "Angular", "C", "C#", "C++", "CakePHP", "Cassandra", "CSS", "Django", "Dovecot", "Drupal", "Excel", "Go", "GSuite", "HTML", "iOS", "Java", "JavaScript", "Joomla", "Libre", "MariaDB", "MongoDB", "MySQL", ".NET", "NGINX", "Node.js", "Objective-C", "Phonegap", "Photoshop", "PHP", "Postfix", "PostgreSQL", "Prestashop", "Python", "React.js", "Redis", "Ruby", "Swift", "Vue.js", "Webpack", "WordPress"]
skillsList.each do |elt|
    Skill.create(name: elt)
end

Enterprise.create name:'Google'
User.create(name: "toto", email:"@", image: "", isRecruiter: true, enterprise_id:1)
Offer.create title:"testOffer", recruiter_id:1
SkillOffer.create offer_id:1, skill_id:1
SkillOffer.create offer_id:1, skill_id:2
SkillOffer.create offer_id:1, skill_id:3
SkillUser.create user_id:1, skill_id:1
