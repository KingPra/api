class FetchIssues
  include Interactor

  def call
    repos.each do |url|
      issues(url).each do |issue|
        attrs = build_attrs(issue)
        c = Challenge.find_or_create_by(title: attrs[:title])
        c.update_attributes! attrs
        challenges << c
      end
    end
  end

  private

  def gh_token
    ENV.fetch("GITHUB_API_TOKEN")
  end

  def repos
    client.repositories("charlottejuniordevs").map(&:full_name)
  end

  def url
    repos.third
  end

  def issues(url)
    client.issues(url).reject(&:pull_request)
  end

  def build_attrs(issue)
    {
      issue_id: issue.id,
      url:      issue.url,
      title:    issue.title,
      body:     issue.body,
      state:    issue.state,
      labels:   issue.labels.map(&:name)
    }
  end

  def client
    @client ||= Octokit::Client.new(access_token: gh_token)
  end

  def challenges
    context.challenges ||= []
  end
end
