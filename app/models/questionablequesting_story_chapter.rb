class QuestionablequestingStoryChapter < ApplicationRecord

  # modules/constants
  include LocationStoryChapterConcern

  # associations/scopes/validations/callbacks/macros
  before_validation do
    if will_save_change_to_likes? && likes > 0
      self.likes_updated_at = Time.zone.now
    end
  end

  after_save do
    if saved_change_to_likes?
      story.update_rating!
    end
    if saved_change_to_word_count?
      story.update!(word_count: story.chapters.sum(:word_count))
    end
  end

  # public/private/protected/classes
  def read_url
    "#{QuestionablequestingStory.const.location_host}#{location_path}"
  end

  def update_rating!(searcher: LocationSearcher::QuestionablequestingSearcher.new)
    searcher.update_chapter_likes!(self)
    self
  end

end
