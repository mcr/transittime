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
