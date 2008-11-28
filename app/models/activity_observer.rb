class ActivityObserver < ActiveRecord::Observer
  def after_create(activity)
    #activity.reload
    board = Board.new
    board.talkable = ActivityBoard.new(:activity_id => activity.id)
    board.save!
  end
end
