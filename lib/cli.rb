class CommandLineInterface

  @@artist = nil

#####################################!!!!!GREETING!!!!!!!#############################################################################


def greeting
  space
  puts '#######WELCOME TO THE ART MANAGMENT DATABASE######'
  space
  puts 'Press ***login*** or ***signup***'
  space
  login_choice = gets.chomp

  if login_choice == "login"
    space
    puts 'enter your name'

    name = gets.chomp

    user_object = Artist.find_by(name: name)

    @@artist = user_object
    self.choices

  elsif login_choice == "signup"

  puts 'Please Enter Your Name To Sign Up'
      name = gets.chomp
      artist = Artist.create_artist(name)
      @@artist = artist
      self.choices

  end

end

#####################################!!!!!USER CHOICES!!!!!!!#############################################################################

def choices
      puts '#######WHAT WOULD YOU LIKE TO DO######'
      space
      puts 'To add new Painting Press ***add***'
      space
      puts 'To find all your Paintings Press ***find***'
      space
      puts 'To delete all your records Press ***delete***'
      space
      puts 'To see all the galleries Press ***galleries***'
      space
      puts 'To change the location of one of your Paintings Press ***update***'
        @command = gets.chomp
        self.actions
end

#####################################!!!!!ACTIONS!!!!!!!#############################################################################


def actions

  #####################################!!!!!ADD FUNCTION!!!!!!!#############################################################################
      if @command == "add"
      puts "######Please enter title of your Painting#######"
        space
        @title = gets.chomp
        space
      puts "######Please enter the price of your Painting######"
        @price = gets.chomp
        space
      puts "######Which of the follwoing galleries do you want your painting to be in######"
      space
        puts get_all_galleries
        space
        @gallery_choice = gets.chomp
        @chosen_gallery = Gallery.all.select {|gallery| gallery.name == @gallery_choice}
        Painting.create({'title' => @title,'price' => @price, 'artist_id' => @@artist.id, 'gallery_id' => @chosen_gallery[0].id})
        space
        puts "###YOUR PAINTING HAS BEEN STORED###"
        self.choices


  #####################################!!!!!VIEW ALL GALLERIES FUNCTION!!!!!!!#############################################################################

elsif @command == "galleries"
  puts "#######Which of the follwoing galleries would you like to see#######"
  space
  puts get_all_galleries
  space
  choice_gallery = gets.chomp
  chosen_gallery = Gallery.all.select {|gallery| gallery.name == choice_gallery}
  paintings_from_chosen_gallery = Painting.all.select {|painting| painting.gallery_id == chosen_gallery[0].id}.to_a
  result = paintings_from_chosen_gallery.map {|gallery| gallery.title}
  space
  puts "###BELOW ARE ALL THE PAINTINGS AT #{choice_gallery}###"
  space
  puts result
  space
  puts "TO ADD A PAINTING TO #{choice_gallery} PRESS ***add***"
  space
  puts "TO GO BACK PRESS ***back***"
  space
  end_choice = gets.chomp
  space
  if end_choice == "add"
    if end_choice == "add"
      space
    puts "Please enter title of your Painting"
    space
      title = gets.chomp
    space
    puts "Please enter the price of your Painting"
    space
      price = gets.chomp
    space
    chosen_gallery = Gallery.all.select {|gallery| gallery.name == choice_gallery}
    Painting.create({'title' => title,'price' => price, 'artist_id' => @@artist.id, 'gallery_id' => chosen_gallery[0].id})
    puts "###Your Painting Painting has been added###"
  end
    self.choices
  elsif end_choice == "back"
    self.choices
  end

  #####################################!!!!!DELETE FUNCTION!!!!!!!#############################################################################

  #####################################!!!!!FIND FUNCTION!!!!!!!#############################################################################

elsif @command == "find"
        puts '###HERE ARE ALL YOUR PAINTINGS###'
        space
        all_users_painting_names
        space
        self.choices

  #####################################!!!!!DELETE FUNCTION!!!!!!!#############################################################################

elsif @command == "delete"
        puts "#######which painting would you like to delete#######"
        space
        puts all_users_painting_names
        space
        @delete_choice = gets.chomp
        finds_painting_for_delete = get_all_users_paintings.select {|painting| painting.title == @delete_choice}
        finds_painting_for_delete[0].delete
        space
        puts "###YOUR PAINIING HAS BEEN DELETED###"
        space
        self.choices

  #####################################!!!!!UPDATE FUNCTION!!!!!!!#############################################################################

elsif @command == "update"
        space
        puts "#######Please choose which painting you would like to move#######"
        space
        puts all_users_painting_names
        space
        @painting_update_choice = gets.chomp
        space
        puts "#######Please choose which gallery you would like to move painting too.#######"
        space
        puts get_all_galleries
        space
        @gallery_choice = gets.chomp
        space
        finds_gallery = Gallery.all.find {|gallery| gallery.name == @gallery_choice}
        finds_painting = get_all_users_paintings.find {|painting| painting.title == @painting_update_choice}
        # finds_painting.gallery_id = finds_gallery.id
        finds_painting.update(gallery_id: finds_gallery.id)

        space
        puts "###YOUR PAINIING LOCATION HAS BEEN CHANGED###"
        self.choices
      else "this did not work"

end
end

def all_users_painting_names
  find_allpaintings = Painting.all.select {|painting| painting.artist_id == @@artist.id}
find_allpaintings.each do |painting| puts "Title:#{painting.title} Artist:#{painting.artist.name} Gallery:#{painting.gallery.name}"
# binding.pry
end
end

def get_all_users_paintings
  Painting.all.select {|painting| painting.artist_id == @@artist.id}
end

def get_all_galleries
  Gallery.all.map {|gallery| gallery.name}
end

def space
puts  "\n"
end

end
