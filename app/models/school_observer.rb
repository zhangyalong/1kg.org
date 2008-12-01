class SchoolObserver < ActiveRecord::Observer
  def after_create(school)
    board = Board.new
    board.talkable = SchoolBoard.new(:school_id => school.id)
    board.save!
  end
end
  