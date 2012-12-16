namespace :db do

	desc "Add initial articles to database"
	task init_articles: :environment do
		puts "Loading initial articles..."

		about = Article.create!(title: "About us", publish: true, menu: 'About',
								content: <<ABOUT
Thank you for taking the time to visit our website! Each of the links on these web pages helps \
provide an overview of our people and their ministry. At Montgomery Hills we strive to bring to \
life our vision of being a place where all people can *belong*, *grow,* and *serve*.

As you browse our site, discover a place where you can belong! Find here a diverse yet unified \
and inclusive community of faith, dedicated to sharing the love of Jesus Christ with the \
community, nation, and world around us. Find here a place of healing, where hurting people can \
find comfort, support, and love. Find here a place for spiritual growth. Find here a place of \
service where people can discover their God-given gifts and use them in ministry.

Please contact us if there is any way that we can minister to you or to your family. We invite \
you to make Montgomery Hills your church home. Come and worship with us at 11:00 a.m. each Sunday, \
or join us for our fellowship dinner at 6:15 each Wednesday. It is our heartfelt desire to make \
you feel welcome here. Together, let us discover the new things that God is doing!

In Christ,

_Joel S. Hawthorne, Pastor_


h5. Where Are You Located?

Montgomery Hills Baptist Church is located at exit 31a of the Capital Beltway, 
on the corner of 9727 Georgia Ave. and Forest Glen Rd.

Our office hours are Monday - Friday from 9:00 a.m. to 5:00 p.m.

Our main phone number is (301) 681-7990

Our fax number is (301) 681-4470


h5. What to Wear

Montgomery Hills is a friendly and warm congregation. We encourage you to wear clothing that \
makes you comfortable. Many church goers choose to dress up and many choose to dress casually. \
During the warmer months of the year, many choose to wear business casual clothing to church. 		
ABOUT
)

		contact = Article.create(title: "Contact", publish: true, menu: 'About:Contact',
								content: "Give us a call at 301-681-7990")
		staff = Article.create(title: "Staff", publish: true, menu: 'About:Staff',
								content: "We have some staff members.  They're awesome.")
		heritage = Article.create(title: "Heritage & Hope", publish: true, 
								menu: 'About:Heritage and Hope',
								content: "Our heritage.")

		news = Article.create!(title: "News", publish: true, menu: 'News',
								content: "No news is good news.")
		youth = Article.create!(title: "Youth program", publish: true, menu: 'Youth',
								content: "We have special programs for youths.  Contct us.")


		ministries = Article.create!(title: "Ministries", publish: true, menu: 'Ministries',
								content: "We have both local and global ministries.")

		church_action_teams = Article.create!(title: "Church Action Teams", publish: true,
								menu: 'Ministries:Church',
								content: "We encourage you to review these Church Action Team " +
								"descriptions and select one or more that you would like to " +
								"join.  Where appropriate, new teams are formed in response to " +
								"groups that own a common vision. To view these team descriptions, " +
								"click on the items listed on the left.")
		children_and_youth = Article.create!(title: "Children and Youth Ministries", publish: true,
								menu: 'Ministries:Children and Youth',
								content: <<CHILDREN_AND_YOUTH
These ministries include activities to take care of children and help them become aware of \
the love of the Lord. These activities range from the care of infants in the nurseries up to \
ministry with teens in the Youth Group.


h5. Nursery Team

The Nursery Team consists of adults and teens that enjoy sharing the love of Christ with the \
infants and toddlers that attend our church. They work on a rotating schedule so that all can \
experience worship and Sunday School in some form. If you love infants, toddlers, rocking chairs, \
and building blocks, this may be the ministry team for you. 


h5. Children Ministry Team

The Children Ministry Team consists of adults who work with our children's Sunday School each \
Sunday from 10-11am. We have classes for grade K-6. Bible stories, prayer, arts and crafts, felt \
boards, and even field trips are all part of this team's activities. On Wednesday evening some of \
the members of this team chaperone the children's choir during weekly rehearsals. If you enjoy \
helping children learn about Christ through many different medias, you will love this team. 


h5. Youth Team

The Youth Team ministry is centered on teaching the Bible in a way that is relevant and engaging. \
The Youth group has monthly fun activities to build community and attendance to youth conferences \
to build spiritual depth. Jesus was relational and intentional with his youth and so are we. Be \
good and love unconditionally.

??Psalm 71:17-18??
CHILDREN_AND_YOUTH
)
		enhancing_worship = Article.create!(title: "Enhancing the Worship Services", publish: true,
								menu: 'Ministries:Enhancing Worship',
								content: <<ENHANCING_WORSHIP
There are a number of ministry teams dedicated to enhancing the worship and education facilities \
within and around the church structure.


h5. Garden Team

The Garden Team is a group of adults who have been assigned areas around the church grounds. They \
beautify areas with flowers, shrubs, mulch and decorations and maintain these areas year 'round. \
If you love digging in the dirt and want to be close to God, please Join our Garden Team.


h5. Library Team

The Library Team is currently in the process of building a library. With its completion, the \
library will be stocked with hundreds of Christian books and references for adults and children. \
Videos and DVDs will be available as well. This ministry team is planning to include tutoring, \
ESOL classes, and a fully functioning computer lab. A separate children's room will have on-going \
activities and story time for the kids. The library and its resources will be open to the church \
and the community. Many gifts are needed in this ministry.


h5. Banner Team

Banners are used on special occasions to enhance the worship environment within the Sactuary. \
The Banner Team spreads the Word of God by making banners for seasonal and special occasions; \
banners that beautify our sanctuary. If you love to cut, sew and glue, our banner team will \
welcome your talents.


h5. Bulletin Board Team

The Bulletin Board Team makes special displays throughout our church to spread God's Word. \
Displays are made to express selected Biblical messages and others are an important means of \
communication within the church membership. If you are a creative-type person, this team may be \
for you. Do you like to work with all sorts of arts, crafts and paints? 
ENHANCING_WORSHIP
)
		fellowship = Article.create!(title: "Fellowship Activities", publish: true,
								menu: 'Ministries:Fellowship Activities',
								content: <<FELLOWSHIP

h5. Sunday Fellowship Gatherings

On the second and third Sundays of each month, a gathering is held after the Worship Service in \
the Bethany Fellowship Hall. On a rotating basis, various groups take the responsibility to \
provide refreshments for these events.


h5. Senior Adult Fellowship Activities

The Classic Club Team is a group that plans events for our senior adults. These events are held \
both in and out of the church. Field trips, luncheons and special speakers, are among the list \
of activities that this team plans. If you have the gift of organizing, planning, or just have \
great ideas; then this may be the team for you.


h5. Wednesday Fellowship Dinners

Except for the summer months, dinners are held at 6:15 pm on Wednesdays. Dinner Teams have the \
responsibility to purchase and prepare the food. A number of teams rotate from week to week in \
this service to the congregation.
FELLOWSHIP
)
		music_team = Article.create!(title: "Music Team", publish: true,
								menu: 'Ministries:Music Team',
								content: <<MUSIC_TEAM
The Minister of Music maintains an overall music program including the Sanctuary Choir and the \
Children's Choir.


h5. Sanctuary Choir

The Sanctuary Choir, directed by Ms. Cheryl Spell, is for all who love to sing. It provides an \
active portion of Sunday worship services and provides special musical events tied to religious \
events and seasons. Choir rehearsals are Wednesday evenings starting at 7 pm. If you have a love \
of music, the choir could be your calling. To volunteer for music activities, contact Cheryl \
personally or at CSpell911@aol.com


h5. Children's Choir

The Children's Choir, directed by Clayton Nunes, provides musical training for the children of \
the church and enhances services with periodic performances. The practices are aided by those who \
love energetic children and assist in providing a fun and somewhat orderly activity. 
MUSIC_TEAM
)
		music_team = Article.create!(title: "Supporting Those in Need", publish: true,
								menu: 'Ministries:Those In Need',
								content: <<THOSE_IN_NEED

h5. Bereavement Team

The Bereavement Team reaches members of this congregation and their families in their times of \
grief and reflection. The Team coordinates all aspects of cooking, cleaning and serving meals \
for these members in need. It is normal to provide a meal in the Fellowship Hall for family \
members following a funeral and burial. The Team always needs volunteers willing to help \
clean up, set up or prepare meals.


h5. Love Notes Team

The Love Notes Team creates the Wednesday night prayer sheets. The prayer sheets help Montgomery \
Hills members continually lift up other members in need throughout the week in their daily prayers \
and meditations. Six or seven people are needed to lead this team every week to accumulate the \
prayer requests and send cards. 
THOSE_IN_NEED
)
		tape_ministry = Article.create!(title: "Tape Ministry", publish: true,
								menu: 'Ministries:Tape Ministry',
								content: <<TAPE_MINISTRY
The Tape Ministry team copies and sends or hand-delivers tapes of the Sunday worship service to \
shut-ins. This ministry is open to all who feel gifted in the area of copying tapes with the \
needed machine provided, addressing and mailing packages, possible visiting with house-bound \
members, or telephoning. 
TAPE_MINISTRY
)
		welcoming_ministry = Article.create!(title: "Welcoming Ministry", publish: true,
								menu: 'Ministries:Welcoming Ministry',
								content: <<WELCOMING_MINISTRY
There are two teams who welcome persons who come to our church on Sundays. There are those who \
greet everyone at the doors and help them in any way needed. In addition, a second team of ushers \
has the responsibility of welcoming people to the Sanctuary and providing any assistance needed \
there.


h5. Greeters Team

The Greeters Team comes together as a group of all ages with a variety of personalities. What we \
have in common is the smile across our faces, in our eyes and/or from our souls; and a desire in \
our hearts to share that with those walking through our doors. All those, of any age, who want to \
make our visitors and members feel welcome, are very much needed.


h5. Ushers Team

The Ushers are those persons who greet, assist with the seating of the congregation and receive \
the tithes and offerings each Sunday. If you have a great smile and like to "hug", this is your \
chance to welcome those to our family.
WELCOMING_MINISTRY
)

	end
end

