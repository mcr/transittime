# This file is part of Nibbles.
#
# Nibbles is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Nibbles is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Nibbles.  If not, see <http://www.gnu.org/licenses/>.

class Gtk::Widget
  def toggle_visibility
    if visible?
      self.visible = false
    else
      self.visible = true
    end
  end
end

class  Gtk::Window
  attr_accessor :osso_context, :toggle_article_list
  def initialize
    @in_fullscreen = false
    super
  end

  def exit_application
    Article.purge
    Gtk.main_quit
  end

  def article_list_frame
    if @article_list.nil?
      @article_list = children.first.children.last.children.first
    end
    @article_list
  end

  def fetcher=(fetcher)
    @fetcher = fetcher
    @feed_list = @fetcher.feed_list_frame
    @article_list = @fetcher.article_list_frame
    @article_frame = @fetcher.article_frame
    @fetcher.start_refresh_thread
  end

  def toggle_fullscreen
    if @in_fullscreen
      unfullscreen
      @in_fullscreen = false
    else
      fullscreen
      @in_fullscreen = true
    end
  end

  def setup_menu
    menu_bar = Gtk::MenuBar.new

    feeds_menu_item = Gtk::MenuItem.new("Feeds")
    menu_bar.append(feeds_menu_item)
    feeds_menu = Gtk::Menu.new
    feeds_menu_item.set_submenu feeds_menu

    view_menu_item = Gtk::MenuItem.new("View")
    menu_bar.append(view_menu_item)
    view_menu = Gtk::Menu.new
    view_menu_item.set_submenu view_menu

    tools_menu_item = Gtk::MenuItem.new("Tools")
    menu_bar.append(tools_menu_item)
    tools_menu = Gtk::Menu.new
    tools_menu_item.set_submenu tools_menu

    toggle_feed_list = Gtk::CheckMenuItem.new("Show feed list")
    toggle_feed_list.active = true
    view_menu.append(toggle_feed_list)
    toggle_feed_list.signal_connect("activate") do
      if @feed_list.visible?
        @feed_list.visible = false
      else
        @feed_list.visible = true
      end
    end

    @toggle_article_list = Gtk::CheckMenuItem.new("Show article list")
    @toggle_article_list.active = false
    view_menu.append(@toggle_article_list)
    @toggle_article_list.signal_connect("activate") do
      if article_list_frame.visible?
        article_list_frame.visible = false
      else
        article_list_frame.visible = true
      end
    end

    add_feed = Gtk::MenuItem.new("Add...")
    feeds_menu.append(add_feed)
    add_feed.signal_connect("activate") do
      add_feed_dialog
    end

    refresh_feeds = Gtk::MenuItem.new("Refresh feeds")
    feeds_menu.append(refresh_feeds)
    refresh_feeds.signal_connect("activate") do
      fetching_thread = Thread.new do
        puts "fetching..."
        @fetcher.fetch_all
      end
      fetching_thread.priority = -3
    end

    delete_feed = Gtk::MenuItem.new("Delete selected")
    feeds_menu.append(delete_feed)
    delete_feed.signal_connect("activate") do
      iter = @feed_list.view.selection.selected
      unless iter.nil? 
        feed = Feed.find(iter[2])
        delete_feed_dialog(feed)
      end
    end

    settings = Gtk::MenuItem.new("Settings...")
    tools_menu.append(settings)
    settings.signal_connect("activate") do
      settings_dialog = SettingsDialog.new("Settings", self, Gtk::Dialog::MODAL | Gtk::Dialog::DESTROY_WITH_PARENT, [Gtk::Stock::OK, Gtk::Dialog::RESPONSE_ACCEPT], [Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_REJECT])
      settings_dialog.run do |response|
        case response
        when Gtk::Dialog::RESPONSE_ACCEPT
          settings_dialog.save!
          @fetcher.start_refresh_thread
        end
        settings_dialog.destroy
      end
    end

    mark_read = Gtk::MenuItem.new("Mark selected as read")
    feeds_menu.append(mark_read)
    mark_read.signal_connect("activate") do
      iter = @feed_list.view.selection.selected
      unless iter.nil?
        Thread.new do
          feed = Feed.find(iter[2])
          unless feed.nil?
            feed.mark_all_articles_as_read
            @feed_list.update
            @article_list.update(@article_list.current_feed, :force_update => true)
          end
        end
      end
    end

    if Device.hildon?
      new_menu = Gtk::Menu.new
      feeds_menu_item.reparent new_menu
      view_menu_item.reparent new_menu
      tools_menu_item.reparent new_menu
      set_menu new_menu
    else
      @vbox = Gtk::VBox.new(false, 0)
      add @vbox
      alignment = Gtk::Alignment.new(1, 0, 1, 0).add menu_bar
      @vbox.pack_start alignment, false, false
      menu_bar = menu_bar
    end
  end

  def append(object)
    if @vbox.nil?
      add(object)
    else
      @vbox.pack_end(object)
    end
  end

  def add_feed_dialog(url = "")
    dialog = Gtk::Dialog.new("Add a feed", self, Gtk::Dialog::MODAL | Gtk::Dialog::DESTROY_WITH_PARENT, [Gtk::Stock::OK, Gtk::Dialog::RESPONSE_ACCEPT], [Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_REJECT])
    feed_field = Gtk::Entry.new
    feed_field.text = url
    feed_field.show
    dialog.vbox.add(feed_field)
    dialog.run do |response|
      case response
      when Gtk::Dialog::RESPONSE_ACCEPT
        banner "Fetching #{feed_field.text}", 10
        fetching_thread = Thread.new do
          @fetcher.fetch feed_field.text
        end
        fetching_thread.priority = -3
      end
      dialog.destroy
    end
  end

  def delete_feed_dialog(feed)
    dialog = Gtk::Dialog.new("Delete feed?", self, Gtk::Dialog::MODAL | Gtk::Dialog::DESTROY_WITH_PARENT, [Gtk::Stock::OK, Gtk::Dialog::RESPONSE_ACCEPT], [Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_REJECT])
    label = Gtk::Label.new("Delete #{feed.title}?")
    label.show
    dialog.vbox.add(label)
    dialog.run do |response|
      case response
      when Gtk::Dialog::RESPONSE_ACCEPT
        feed.delete
        iter = @feed_list.view.selection.selected
        unless iter.nil?
          Thread.new do
            @feed_list.list.remove iter
            @article_list.update
            @article_frame.update
          end
        end
      end
      dialog.destroy
    end
  end

  def banner(message, time = 5)
    if Device.hildon?
      unless @banner
        if message.length > 50
          message = message[0,50] + "..."
        end
        @banner = Hildon::Banner.show_animation self, message
        @banner.show_all
        Thread.new do
          sleep time
          @banner.destroy
          @banner = nil
        end
      end
    else
      puts "#{message} (#{time})"
    end
  end
end
