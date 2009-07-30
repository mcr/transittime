require 'rubygems'
require 'net/http'
require 'time'
require 'rubygems' unless Device.hildon?
require 'libosso' if Device.hildon?
require 'sqlite3'

class PlaceDialogue

  def initialize
    if Device.hildon?
      program = Hildon::Program.get_instance
      @window = program.add_window Hildon::Window.new
    else
      @window = Gtk::Window.new
    end

    # see http://ruby-gnome2.sourceforge.jp/hiki.cgi?Gtk%3A%3ATable
    @panel = Gtk::Table.new(5, 2)
    
    @title         = Gtk::Label.new
    @title.set_markup("<small>Transit Time</small>")
    
    # font_desc=\"Andale Mono\"
    @clock         = Gtk::Label.new
    @clock.set_markup("<span size=\"14\" >08:13</span>")

    do_the_rest
  end

  def update_origin_button
    @origin_button.label="Currently at:\n" + @current_place.name

    @panel.attach @origin_button, 0, 1, 1, 2
    @origin_button.show
  end

  def create_origin_button

    @places          = Place.find(:all)
    @current_place ||= @places.first
    @current_place ||= Place.new(:name => "Unknown")

    @origin_button ||= Gtk::Button.new
    @origin_button.signal_connect("pressed") do
      puts "origin button pressed\n"
      self.make_origin_select
    end
    update_origin_button
  end

  def create_destination_button

    @places          = Place.find(:all)
    @destination_place ||= @places.first
    @destination_place ||= Place.new(:name => "Unknown")

    @destination_button ||= Gtk::Button.new
    @destination_button.signal_connect("pressed") do
      puts "dest button pressed\n"
      self.make_destination_select
    end
    update_destination_button
  end

  def update_destination_button
    @destination_button.label="Heading to:\n" + @destination_place.name

    @panel.attach @destination_button, 0, 1, 2, 3
    @destination_button.show
  end

  def places_combo
    combo = Gtk::ComboBoxEntry.new(true)
    @places.each { |place|
      combo.append_text(place.name)
    }
    combo
  end
  
  def origin_places_combo
    combo = places_combo
    combo.signal_connect('changed') do
      puts "origin combo changed\n"
      self.origin_picked if combo.active>0
    end
    combo.child.signal_connect('activate') do
      puts "origin combo activate\n"
      self.origin_picked
    end
    combo
  end

  def destination_places_combo
    combo = places_combo
    combo.signal_connect('changed') do
      puts "dest combo changed\n"
      self.destination_picked if combo.active>0
    end
    combo.child.signal_connect('activate') do
      puts "dest combo activate\n"
      self.destination_picked
    end
    combo
  end

  def make_origin_select
    @origin_combo ||= origin_places_combo
    @panel.remove(@origin_button)
    @panel.attach(@origin_combo, 0,1,1,2)
    @origin_combo.editing_done
    @origin_combo.show
  end

  def origin_picked
    @panel.remove(@origin_combo)
    @current_place = Place.find_or_create_by_name(@origin_combo.active_text)
    update_origin_button
  end

  def make_destination_select
    @destination_combo ||= destination_places_combo
    @panel.remove(@destination_button)
    @panel.attach(@destination_combo, 0,1,2,3)
    @destination_combo.editing_done
    @destination_combo.show
  end

  def destination_picked
    @panel.remove(@destination_combo)
    @destination_place = Place.find_or_create_by_name(@destination_combo.active_text)
    update_destination_button
  end

  def make_quit_button
    @quitbutton = Gtk::Button.new("quit")
    @quitbutton.signal_connect('pressed') do
      Gtk.main_quit
    end
    @panel.attach @quitbutton, 0, 2, 5, 6
  end

  def do_the_rest
    more_options  = Gtk::Button.new("More\nOptions")
    button1 = Gtk::Button.new("16W")
    button2 = Gtk::Button.new("151S")
    button3 = Gtk::Button.new("16E")
    button4 = Gtk::Button.new("151N")
    button5 = Gtk::Button.new("2E")
    
    @panel.attach @title,         0, 1, 0, 1
    @panel.attach @clock,         1, 2, 0, 1
    create_origin_button
    create_destination_button
    @panel.attach button1,       1, 2, 1, 2
    @panel.attach button2,       1, 2, 2, 3
    @panel.attach button3,       0, 1, 3, 4
    @panel.attach button4,       1, 2, 3, 4
    @panel.attach more_options,  0, 1, 4, 5
    @panel.attach button5,       1, 2, 4, 5
    
    @window.append(@panel)
    make_quit_button
    @window.set_default_size(200, 400).show_all
    #article_list_frame.visible = false
    
    GLib.application_name = "Transit Time"
    
    Thread.new do
      @window.signal_connect("delete_event") { @window.exit_application }
      @window.signal_connect("key-press-event") do |window, event|
	case event.keyval
	when Gdk::Keyval::GDK_F6, Gdk::Keyval::GDK_F11
	  @window.toggle_fullscreen
	when Gdk::Keyval::GDK_F7
	  @window.toggle_article_list.active = !article_list_frame.visible?
	when Gdk::Keyval::GDK_F8
	  feed_list_frame.toggle_visibility
	end
    end

      if Device.hildon?
	require "#{TT_LIB}/osso"
      end

  end


  end
end
