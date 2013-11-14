module DBC

  require 'dbc-ruby'
  
  # key to all this making sense is that real names can't appear
  # and real bios should never be linked to names
  module Faker
    class User
      # def initialize(args = nil)
      #   self.setup
      # end

      def self.setup
        return unless @users.nil?

        begin
          @users = DBC::User.all(per_page: 5).map{|u| [u.name, u.bio]}
        rescue ArgumentError => e
          puts "-"*50
          puts e
          puts "-"*50
          raise e
        end
      end

      # uses dbc-api to fetch a list of names
      # munge them up and spit out unique ones
      # from the real ones        
      def self.name
        setup
        "#{first_name} #{last_name}"
      end

      def self.first_name
        @users.sample.first.split.first
      end

      def self.last_name
        @users.sample.first.split.last
      end

      # similar to name
      def self.bio
        setup
        @users.map(&:last).reject(&:nil?).reject(&:empty?)

        # @users.sample(rand(3..5))
        # @users.sample.last.split(/[\.!\?]/)

        # to make a new bio:
        # - start with a set of 3-5 actual bios
        # - split them up into sentences
        # - split the sentences into words
        # - zip the words into new sentences
        # - recombine into a new bio of random words


      end

    end
  end
end



