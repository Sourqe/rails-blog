class Article < ApplicationRecord
    # relationships
    has_many :comments
    has_many :taggings
    has_many :tags, through: :taggings
    has_attached_file :image
    validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
    
    def tag_list
        # returns a list of all tags
        self.tags.collect do |tag|
            tag.name
        end.join(", ")
    end

    def tag_list=(tags_string)
        # store the tags while first splitting the input, removing whitespaces, 
        # and converting everything to lower case
        tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
        
        # go through each tag in tag_names and find or create a tag with a new name
        new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }

        # collect the new or found tags and assign to article
        self.tags = new_or_found_tags
    end
end
