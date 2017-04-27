class FetchIssues
  include Interactor

  def call
    repos.each do |repo|
      issues(repo).each do |issue|
        attrs = build_attrs(issue, repo)
        c = Challenge.find_or_create_by(github_issue_id: attrs[:github_issue_id])
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
    @repos ||= jr_devs_repos + authorized_challenge_repos
  end

  def jr_devs_repos
    @jr_devs_repos ||= client.repositories("charlottejuniordevs").map(&:full_name)
  end

  def authorized_challenge_repos
    @authorized_challenge_repos ||= YAML.load_file("config/authorized_challenge_repos.yml")
  end

  def issues(url)
    client.issues(url).reject(&:pull_request)
  end

  def build_attrs(issue, repo)
    {
      repo:            repo,
      github_issue_id: issue.id,
      url:             issue.html_url,
      title:           issue.title,
      body:            issue.body,
      state:           issue.state,
      labels:          issue.labels.map(&:name)
    }
  end

  def client
    @client ||= Octokit::Client.new(access_token: gh_token)
  end

  def challenges
    context.challenges ||= []
  end
end
