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

		contact = Article.create!(title: "Contact", publish: true, menu: 'About:Contact',
								content: "Give us a call at 301-681-7990")
		staff = Article.create!(title: "Staff", publish: true, menu: 'About:Staff',
								content: "We have some staff members.  They're awesome.")
		heritage = Article.create!(title: "Heritage & Hope", publish: true, 
								menu: 'About:Heritage and Hope',
								content: <<HERITAGE
Heritage & Hope is the endowment ministry of Montgomery Hills Baptist Church. Heritage & Hope \
celebrates the accomplishments of a century of witness, but is pointed toward the future, \
designed to make sure that for years to come there will be a vibrant church for the next \
generations.

Very simply, Heritage & Hope is an endowment fund, or really a set of funds, to which all of us \
are invited to give. As an endowment, the Heritage & Hope Fund will not be spent; it will be \
invested, so that income from that investment can produce resources for years to come. When you \
give to Heritage & Hope, you can have the confidence that, unless extreme circumstances occur, \
your gift will keep on giving in perpetuity.

Four funds will be set up:
* The Property Fund, to be used for improvements to the existing church property or acquisition of \
additional property;
* The Missions Fund, to be used for missionary tasks at home, across the nation, or around the world;
* The Ministries Fund, to be used for human need ministries identified by the deacons;
* The General Fund, for other opportunities that may arise and are agreed to by the church.

How can you invest in the future through gifts to a Heritage & Hope fund? A Legacy Gift is one \
that draws on the resources you will leave after your death. The simplest form of a Legacy Gift \
is a bequest in your will. It could be a stated amount of money; or a percentage of your estate; \
or the residue or your estate after other expenses and bequests are paid.

Our Endowment Committee can help you determine whether one of these approaches would have tax \
benefits for you.
HERITAGE
)

		history = Article.create!(title: "History", publish: true, 
								menu: 'About:History',
								content: <<HISTORY
In November, 1912 the Columbia Association of Baptist Churches purchased property on the corner \
of 7th and Randolph Sts. N.W. for the purpose of building a Baptist church. During a mass meeting \
of interested Baptists on December 1, 1912, it was decided to establish a new church, the first \
service to be held on December 29, 1912. A permanent church organization was thus established \
under the name of Petworth Baptist Church. The premises of 4009 9th St. N.W. were rented for \
subsequent meetings, and the following Sunday, January 5, 1913, the Sunday school was organized \
and worship was led by Rev. Quirof Harlan, one of 63 charter members.

In January 1914, Rev. Owen P. Lloyd was called as first pastor. During his pastorate, the first \
church building was erected at a cost of $17,500. At this time, the church was on the outskirts \
of the city, with farmland to the north, but the "Friendly Church" as it was called then, made \
steady growth. Rev. Lloyd resigned in September, 1915, and Dr. F. Vernon Atkinson served until \
the call of a new pastor.

In July, 1916, Rev. F. Paul Langhorne became the second pastor, and during the next seven years, \
membership grew from 104 to 367, and a beautiful new sanctuary was built. Rev. Langhorne resigned \
in December, 1923 and was succeeded in June, 1924 by Rev. Henry J. Smith. During Rev. Smith's \
pastorate, the membership increased to 880, and the church liquidated all its indebtedness.

Following the resignation of Rev. Smith in April, 1940, the church called the Rev. James P. \
Rodgers, who assumed duties in December, 1940. Under Rev. Rodgers, the church purchased an annex \
across the street from the sanctuary and began a building fund for future expansion. When Rev. \
Rodgers resigned in July 1948, church membership had risen to over 1,000.

Chaplain LeRoy Raley served as interim pastor until the arrival of Rev. S. Lewis Morgan on June, \
1949. In July, 1954, the church voted to purchase property on Georgia Ave. in Silver Spring, MD. \
Services were initiated on February 14, 1955 in a rented house at 9504 Woodland Drive. By May, \
1955, the Montgomery Hills Chapel had 48 charter members. In February, 1957, a new church building \
was completed on Georgia Ave. and Forest Glen Road. Under Rev. Morgan and three successive \
Associate Pastors, Rev. R. Brown Hughes, Rev. Jack Coffey, and Rev. Nathan C. Brooks III, one \
single church functioned at two sites.

On January 13, 1963, the final service was held at the Petworth location, and on January 20, 1963 \
the church began meeting together as a single congregation in Montgomery Hills. The present \
sanctuary and educational wing were completed and dedicated in February, 1965. Following the \
resignation of Rev. Morgan in January, 1968, Dr. Sidney Larson served as Interim Pastor until \
the call of Dr. George B. Hawthorne in December, 1968.

During the pastorate of Rev. Hawthorne, the church shared its facilities with a new Korean Baptist \
Congregation and called Dr. Menter P. German as Associate Pastor. With the resignation of Dr. \
Hawthorne in December, 1974, Dr. German served as Acting Pastor, assisted by Dr. Clarence W. \
Cranford and Dr. James Langley, until the call in July, 1975, of Rev. Donnell R. Harris.

Rev. Harris served Montgomery Hills for 23 years. During those years, the church completed \
payments on its mortgage and celebrated that accomplishment on the occasion of the church's 70th \
anniversary. In April, 1977, the church called the Rev. Bruce C. Salmon as Associate Pastor. Dr. \
German continued to serve the church as Minister of Visitation until his death in 1979. Rev. Joel \
S. Hawthorne, son of the former pastor, was called as Associate Pastor in May, 1985. The church \
sanctuary was renovated in preparation for the 75th anniversary celebration in 1987. These years \
were also notable for the addition of the Bethany Baptist Church of Washington, D.C., whose \
members united with Montgomery Hills in December, 1986. Upon the resignation of Rev. Hawthorne in \
1992, Rev. David C. Lohff was called in March, 1993, and served until October of 1995.

Following the resignation of Rev. Harris in 1998, the church called the Rev. Joel S. Hawthorne, \
who began his pastorate in July of 1998. The church served as a beacon of hope and prayer to the \
Montgomery Hills community in the aftermath of the tragedies of September 11th, 2001. In more \
recent years, a steering team was established to focus on a new vision, that of being a church \
where all people can "belong, grow, and serve." A major construction project was initiated, with \
the church adding a new elevator, and the entire building was made handicap accessible. \
Petworth-Montgomery Hills has a rich history, and has every reason to look forward with hope. May \
God continue to bless the Petworth-Montgomery Hills Baptist Church as we worship, grow, and \
serve together.
HISTORY
)

		mission = Article.create!(title: "Mission Statement", publish: true, 
								menu: 'About:Mission Statement',
								content: <<MISSION
_The following Mission Statement was developed by the congregation of the Montgomery Hills Baptist Church._

Having accepted Jesus Christ as our personal Savior and followed Him in baptism, we, the members \
of Montgomery Hills Baptist Church covenant to fulfill our Christian calling as God shall enable \
us by:

Providing a place where all people can *Belong*. We will invite, welcome, accept, encourage, and \
walk together in Christian love. We will share each other's joys and bear one another's burdens. \
We will create a place for all to belong within the warmth of God's love and care.

Providing a place where all people can *Grow*. We will gather regularly for worship. We will \
study the Scriptures for God's guidance, and remember our privilege of prayer. We will encourage \
personal growth for ourselves and others and strive to identify and exercise our unique spiritual \
gifts. We will follow Jesus Christ in all things and support the growth of all members of the \
community.

Providing a place where all people can *Serve*. We will devote ourselves to sharing the Gospel \
throughout this community and the world. We will strive to serve as the hands and heart of Christ \
through ministry teams, offering our personal gifts and abilities as ministry in Christ's name.

So we strive, throughout our lives, to give glory to God, who has called us out of darkness into \
the marvelous light.

Adapted
MISSION
)

		news = Article.create!(title: "News", publish: true, menu: 'News',
								content: "No news is good news.")
		youth = Article.create!(title: "Youth program", publish: true, menu: 'Youth',
								content: <<YOUTH
Welcome to Montgomery Hills Baptist Church Ministries for Youth
(Grades 7 to 12).

Our youth team is dedicated to serve the Lord by ministering to our youth. It is our desire for \
our youth to have a close and intimate walk with Jesus Christ.

h5. Our Mission

We exist to lead our middle and high school youth into authentic faith in Jesus, encourage them \
to grow as lifelong followers of Christ, help them discover their spiritual gifts, and send them \
out to serve and transform lives for Jesus Christ.

h5. Our Values

# We value Christian Discipleship, striving to live Christ-centered lives that reflect the love of God.
# We value worship, loving God with all our heart, soul, mind, and strength.
# We value Community, where all feel welcomed and accepted as children of God.
# We value the Bible, and our programming, teaching, and reflect the truth, ideas, and values of \
the scriptures, revealed through prayer and study.
# We value building strong relationships with friends, family, and church community.
# We value serving together with excellence, providing many opportunities for youth to serve God \
and others, and providing youth with tools to discover and use their own unique gifts for ministry.
# We value prayer, talking and listening to God, and seeking after God's will.

h5. Youth Team

Our youth ministry is led by Aseer Samuel, Celina Samuel, Peggy Kullberg, and Chuck Kullberg. We \
are excited to be part of the youth ministry. For more information on our ministry please contact \
Aseer, Celina, or Peggy or Chuck at the church office, (301) 681-7990.

Aseer Samuel -  _aseer@verizon.net_
Celina Samuel - _celinabb@hotmail.com_
Peggy, Chuck Kullberg - _Kullberg@verizon.net_
YOUTH
)

		parent_info = Article.create!(title: "Parent Information", publish: true, 
								menu: 'Youth:Parent Information',
								content: <<PARENT_INFO
Our vision is to lead middle and high school youth into authentic faith in Jesus, and to \
encourage them to grow as lifelong followers of Christ. Our desire is to help our youth to \
discover their spiritual gifts, and send them out to serve and transform lives for Jesus Christ.

Opportunities for Parents

Parents can get involved by helping us in the following:

# Praying for the ministry
# Providing food for Wednesday Wahoo
# Offering a home for an event
# Sharing your testimony or expertise in an area
# Chaperoning an event

If you would like to help, please contact anyone on the youth team.

Resources for Parents - Coming Soon

Books (available at our library)

Websites:
"www.crosswalk.com/parenting/":http://www.crosswalk.com/parenting/
PARENT_INFO
)								

		weekly = Article.create!(title: "Weekly Gatherings for Youth", publish: true, 
								menu: 'Youth:Weekly Gatherings',
								content: <<WEEKLY

Our weekly gatherings are led by Aseer Samuel, Celina Samuel and Cheryl Spell. Please contact \
the youth leaders if you have any questions.

Aseer Samuel - _aseer@verizon.net_  cell phone: (301) 404-2803
Celina Samuel - _celinabb@hotmail.com_  cell phone: (202) 446-7947
Cheryl Spell - _cspell911@aol.com_  cell phone: (301) 633-6211

Youth Sunday School - 9.45am-10.30am


Wednesday Wahoo - 6.30pm-8.00pm

Games, Snacks and "Characters with Character!" This summer we are planning to have a great time \
together playing, eating and learning about Bible characters whose personalities were changed \
because of their relationship with God.

We will start promptly at 6.30pm and end on time at 8.00pm. Entrance and exit is through the \
parking lot door. Door will be locked at 6.45pm so if you're late, call Cheryl's cell phone so \
someone can let you in. If you need a ride, call someone on the youth team and we'll be glad to \
be your chariot. Bring your Bibles!
WEEKLY
)

		ministries = Article.create!(title: "Ministries", publish: true, menu: 'Ministries',
								content: <<MINISTRIES
The ongoing ministry of Montgomery Hills is directed through our Ministry Action Teams \
(MAT Teams). We encourage the creation of new ministry teams as the Lord gives vision and \
leads people into service. Our purpose is to help each person find a fulfilling and meaningful \
PLACE of service in the Body of Christ. 

Ministry teams have been formed by persons who feel led to use their personal gifts to aid \
others. Some of these activities are ministries to those outside the church congregation and \
some are services of love to others within the membership.
MINISTRIES
)

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

		community_teams = Article.create!(title: "Community and World Action Teams", publish: true,
								menu: 'Ministries:Community and World',
								content: <<COMMUNITY_TEAMS
Teams through which we minister to others. These teams are listed on the left side of this \
page. Click on the one of interest to you.
COMMUNITY_TEAMS
)

		habitat_for_humanity = Article.create!(title: "Habitat for Humanity Team", publish: true,
								menu: 'Ministries:Habitat for Humanity',
								content: <<HABITAT
The Habitat for Humanity team is planning a mission trip to Baton Rouge, LA from April 22-28. \
Eleven members of the team will be participating in a "Blitz Build" for those who lost their \
homes during Hurricane Katrina. Volunteers will be working on all areas of construction, \
hospitality, landscaping, painting and others. Countless lives have been forever changed by the \
hurricanes in the gulf region. But the people of the Gulf Coast are rebuilding, with the help of \
hundreds of volunteers from across the nation! 
HABITAT
)

		international = Article.create!(title: "International Ministries", publish: true,
								menu: 'Ministries:International',
								content: <<INTERNATIONAL
We support a number of foreign mission activities. For the moment we list here activities of one \
of these, the Schellingers.

<hr />
!/assets/schellingerray300.thumbnail.jpg!

Adalia and Ray work with the women of the "Dios Con Nosotros" Baptist Convention of Northern Baja \
California, Mexico. Together with the women of Tijuana, they have begun Deborah's House, a \
ministry to victims of domestic violence. Deborah's House brings together a diverse mix of \
services, including crisis intervention, healthcare, shelter for victims, counseling and \
education for both victims and abusers in these situations. Ray and Adalia also offer workshops \
to all churches in the region on alternatives to violence, self-esteem, relationship skills, and \
communication.

<hr />
RECENT NEWSLETTERS

h5. SHELTER

_by Raymond Schellinger, Missionary, Mexico (March 2010)_

I have just returned from 2 1/2 weeks at Deborah's house, where I was able to host some good \
friends who accompanied me there to bring our second story into full use. It was also extremely \
important to encourage our partners in this ministry as they have faced some struggles and are \
trying to hold on. So much of my life with the shelter since 2005 has been such busy work, and I \
have had little time to sit, reflect and enjoy. This trip was no exception, until, late one night, \
with almost everyone asleep, I took a walk around the shelter, prayed some, and just tried to take \
it all in. This place has become what it was intended to be, an oasis in the midst of a difficult \
world, a rest from life's storms. It has become sacred ground, and I felt so good to feel it that \
night as I was saying goodbye once again, until August.


h5. GIFTS TO THE WORLD MISSION OFFERING

_by Raymond Schellinger (October 2009)_

Over the past couple years, we have had the opportunity to provide shelter for more than 60 women \
and their children. At Deborah's House they have found respite from violent storms and the \
opportunity to begin life anew.

One of these women who has just recently left the shelter is "Esperanza". When she came to us she \
was barely communicative, having suffered from extreme abuse. She came with her three children, \
and the oldest daughter, "Sarah", 16, had been abused by her step-father and was pregnant with his \
child.

Esperanza, non-medicated bipolar and obsessive/compulsive, no longer knew how to cope with any of \
this and spent most of her time retreating into the recesses of her own mind. Sarah was \
overburdened trying to deal with the responsibilities that her mother neglected in caring for her \
two younger siblings, at the same time that she had to deal with her own abuse and pregnancy. For \
most of her stay at the shelter, she never made eye contact with any of the adults. Her gaze was \
always fixed on the floor.

Esperanza's duties in the house were to mop the floor, which she probably did 5 times daily and \
more than that if she could get away with it. When she washed clothes, we had to supervise her \
closely or she would wash the same load ten times before she would hang them to dry. I am not \
exaggerating. She once used a whole box of detergent on one load of laundry. And whenever we had \
to negotiate limits with her she would become angry or retreat once more into her room. Alone, \
she constantly pulled out her own hair, and in public always had to use a hat or a wig.

She was resentful or withdrawn almost all the time. Everyday we would ask her how she was and \
everyday she would have something to complain about.

She made progress at the shelter, but we were still worried when it came time for Esperanza, her \
two youngest children, and an extremely pregnant Sarah, to leave the shelter. They moved to a home \
a cousin owned quite a distance from Deborah's House and from the area she had always known. How \
would they cope?

We helped them to move in, found the family a stove and refrigerator, and made and installed a \
kitchen counter and sink. We returned a couple weeks later to bring some more supplies. Esperanza \
was staring out the window into space when she suddenly began to cry and said loudly, "I didn't \
know people like that existed." I looked out the window to see who she was talking about. There \
was nobody there. I asked, "People like who?" Still staring out the window, she said, "People who \
help you and never ask you for anything in return. People like you. All of you. Deborah's House."

This was unexpected. After all the complaining and griping, we didn't see this coming. She got \
it. She finally figured out that we didn't want anything from her, but for her own well being. I \
suppose that Esperanza had never been in a relationship with anyone that didn't want something \
back from her. She had paid such a steep price for everything in her life, and always much more \
than anything she had received in return. Now that has changed.

Just as we were getting in the car to leave that day, Sarah called out for us to stop. She looked \
us in the eye, and crying again, said, in well rehearsed English "Thank you very much." Then she \
hugged us, and said good-bye.

I share this with you because I treasure that moment of gratitude from Esperanza and Sarah so \
much, and because it rightly belongs to all of you. We have only been able to be a part of this \
shelter because of people like you. People who give of their time and money, encouragement and \
prayers without asking for anything in return.

Without you, Deborah's House, and Adalia's and my ministry with it would not be possible.

Without you, Esperanza would still be with her abusive partner. Without you, Sarah would still be \
living a torment greater than we dare contemplate.

We invite you to continue to partner with us. We thank God for people like you. 
INTERNATIONAL
)

		johenning = Article.create!(title: "Johenning Center", publish: true,
								menu: 'Ministries:Johenning Center',
								content: <<JOHENNING
The Johenning Baptist Community Center in Anacostia, provides quality out-of-school time \
enrichment through tutoring (with completion of homework and additional academic instruction), \
computer lab instruction, field trips, parties, and social skill building exercises and role-plays \
Monday through Thursdays from 3:30pm to 6pm, except for holidays.

The Johenning Center Team works on various projects throughout the year in collaboration with the \
Center. Their main purpose is to support the Johenning Baptist Center, which in turn supports kids \
in need. Food baskets are gathered at holiday times, and clothing, art, and school supplies are \
collected for the children. Monetary donations are sent during the "Souper Bowl" and field trips \
to the center are planned for anyone interested in helping in a more hands-on way. This ministry \
fills a great need in our nation's capitol. 
JOHENNING
)

		nursing = Article.create!(title: "Nursing Center Ministry", publish: true,
								menu: 'Ministries:Nursing Center',
								content: <<NURSING
One Saturday morning each month a team visits the Layhill Nursing Center on Bel Pre Road in \
Silver Spring. An informal worship service is conducted for the residents and communion is \
served. The gifts of compassion, a love of people, singing, reading scripture, sharing poetry \
or stories, praying, leading, playing the piano or other instruments, serving, greeting, and \
visiting, are among those needed for this ministry. If you would like to join this ministry \
team, contact Mrs. Peggy Kullberg at: _kullberg@verizon.net_ 
NURSING
)

		signboard = Article.create!(title: "Signboard Ministry", publish: true,
								menu: 'Ministries:Signboard',
								content: <<SIGNBOARD
The Signboard Ministry team maintains the message on the Church Signboard on Georgia Avenue. \
Ever wonder what draws someone to our Church every Sunday? Those who drive by our church on \
their hurried ways, waiting for that eternal traffic light at Georgia Avenue and Forest Glen \
Road, have plenty of time to contemplate their lives. An encouraging statement might be what \
someone needs on a given day to draw them closer to God. If you have a way with phrases, why \
don't you put those phrases up in "Lights" for all to see? We are always looking for unique \
words to bring that one soul to God. 
SIGNBOARD
)

		van = Article.create!(title: "Van Ministry", publish: true,
								menu: 'Ministries:Van',
								content: <<VAN
The Van Ministry is for adults who have the gift of good driving and enjoy people. Our Van Team \
goes out each Sunday morning before Sunday School and picks up children and adults that otherwise \
might not be able to get to church.
VAN
)

		womens = Article.create!(title: "Ministries:Women's Ministry", publish: true,
								menu: "Ministries:Women's Ministry",
								content: <<WOMENS
The Baptist Women's Missionary Team meets at the church once a month during the day. They have \
lunch together followed by a time of fellowship, special mission speakers, or work on various \
mission projects. They work on such things as preparing baby items to be sent to mission fields \
and school kits for home and foreign missions. They also contribute to the American Baptist Love \
Gift and continue to keep in touch with former long-time missionary, Wana Ann Fort through cards, \
letters and remembrances. 
WOMENS
)


	end
end

