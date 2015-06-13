# Helpers for better embedding and manipulation of videos
module VideosHelper
  # Regex to find YouTube's video ID
  YOUTUBE_REGEX = %r(^(http[s]*:\/\/)?(www.)?(youtube.com|youtu.be)\/(watch\?v=){0,1}([a-zA-Z0-9_-]{11}))

  # Embeds YouTube video of given URL in an iframe
  #
  # @param url [String] URL of desired video
  # @param width [String] width of embedded video. Can be any valid CSS unit
  # @param height [String] height of embedded video. Can be any valid CSS unit
  # @return [String] HTML string of embedded video
  def youtube_embed(url)
    youtube_id = find_youtube_id(url)

    result = %(<iframe title="YouTube video player"
                src="//www.youtube.com/embed/#{ youtube_id }?controls=0&disablekb=1&loop=1&playsinline=1&rel=0&showinfo=0"
                frameborder="0" allowfullscreen></iframe>)
    result.html_safe
  end

  # Finds YouTube's video ID from given URL or [nil] if URL is invalid
  # The video ID matches the RegEx \[a-zA-Z0-9_-]{11}\
  #
  # @param url [String] URL of desired video
  # @return [String] video ID of given URL
  def find_youtube_id(url)
    url = sanitize(url).to_str

    matches = YOUTUBE_REGEX.match url

    if matches
      matches[6] || matches[5]
    end
  end
end
