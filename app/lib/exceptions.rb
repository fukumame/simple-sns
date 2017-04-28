module Exceptions
  class DuplicateFollowedUserError < StandardError; end
  class DuplicateFavoritePostError < StandardError; end
  class DuplicateFavoriteReplyError < StandardError; end
end