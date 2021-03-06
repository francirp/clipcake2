# encoding: utf-8
# Autogenerated by the db:seed:dump task
# Do not hesitate to tweak this to your needs

User.create([
  { :email => "ryan.p.francis@gmail.com", :first_name => "Ryan", :last_name => "Francis", :password => "password", :billing_address => "", :billing_city => "", :billing_state => "", :billing_phone => "", :shipping_address => "", :shipping_city => "", :shipping_state => "", :shipping_phone => "", :access_token => "", :facebook_id => 7725785, :is_activated => true, :full_name => "Ryan Francis" },
  { :email => "hannahmackay18@gmail.com", :first_name => "Hannah", :last_name => "Mackay", :password => "password", :billing_address => "", :billing_city => "", :billing_state => "", :billing_phone => "", :shipping_address => "", :shipping_city => "", :shipping_state => "", :shipping_phone => "", :access_token => "", :facebook_id => 7725454, :is_activated => true, :full_name => "Hannah Mackay" },
  { :email => "kelscramer@gmail.com", :first_name => "Kelsey", :last_name => "Francis", :password => "password", :billing_address => "", :billing_city => "", :billing_state => "", :billing_phone => "", :shipping_address => "", :shipping_city => "", :shipping_state => "", :shipping_phone => "", :access_token => "", :facebook_id => 187700640, :is_activated => true, :full_name => "Kelsey Francis" }
], :without_protection => true )

user1 = User.first.id
user2 = user1 + 1
user3 = user1 + 2

Book.create([
  { :captain_id => nil, :recipient_fb_id => 7725454, :occasion => "Birthday", :event_date => nil, :reminder_1 => nil, :reminder_2 => nil, :final_reminder => nil, :contribution_deadline => nil, :book_size => "8.5\" x 11\"", :invite_message_subject => "Photobook for Hannah's 25th Birthday!", :invite_message_body => "Help me create this photobook for Hannah's 25th birthday! I think she's going to love it.", :sharing_preference => "Social", :name => "Hannah's 25th Birthday!" },
  { :captain_id => nil, :recipient_fb_id => 187700640, :occasion => "Wedding", :event_date => nil, :reminder_1 => nil, :reminder_2 => nil, :final_reminder => nil, :contribution_deadline => nil, :book_size => "8.5\" x 11\"", :invite_message_subject => "Celebrate Casey and Kelsey's Marriage!", :invite_message_body => "Help me create this photobook as a gift to Kelsey and Casey for their wedding!", :sharing_preference => "Social", :name => "Kelsey and Casey's Wedding Gift" }
], :without_protection => true )

book1 = Book.first.id
book2 = book1 + 1
book3 = book1 + 2

Page.create([
  { :book_id => book1, :user_id => user1, :layout => "layout1", :background_color => nil, :background_image_url => nil }
], :without_protection => true )

page1 = Page.first.id
page2 = page1 + 1
page3 = page1 + 2

Photo.create([
  { :user_id => user1, :book_id => book1, :page_id => page1, :position => 2, :source_url => "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-frc1/c55.55.688.688/s320x320/576433_10100855873629258_1824516941_n.jpg", :caption => "Lookin' goooood", :fb_created_date => nil, :fb_object_id => nil, :is_picked => nil }
], :without_protection => true )



Role.create([
  { :book_id => book1, :user_id => user1, :role_type => "Captain" }
], :without_protection => true )



Text.create([
  { :user_id => user1, :book_id => book1, :page_id => page1, :message => "Happy birthday Hannah! You're the best!", :position => 1, :font_size => "16", :font_type => "", :font_color => "Black" }
], :without_protection => true )


