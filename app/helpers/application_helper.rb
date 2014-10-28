module ApplicationHelper
  def markdown(text)
    return if text.nil?
    @renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML.new,
                                          escape_html: true,
                                          safe_links_only: true)
    @renderer.render(text).html_safe
  end

  def vote_panel(voteable)
    path = method("vote_#{voteable.class.to_s.underscore}_path")
    existing_vote = voteable.votes.find_by(user: current_user)
    content_tag(:div, class: :vote) do
      String.new.tap do |out|
        out << content_tag(:div, class: "vote-count") do
          voteable.votes.sum(:value).to_s
        end
        unless voteable.respond_to?(:user) && voteable.user == current_user
          if existing_vote
            out << content_tag(:div) do
              if existing_vote.value == 1
                fa_icon("thumbs-o-up 2x")
              else
                fa_icon("thumbs-o-down 2x")
              end
            end
          else
            out << content_tag(:div) do
              link_to(fa_icon("thumbs-up 2x"), path.call(voteable, value: 1), method: :post, remote: true)+
              link_to(fa_icon("thumbs-down 2x"), path.call(voteable, value: -1), method: :post, remote: true)
            end
          end
        end
      end.html_safe
    end
  end
end
