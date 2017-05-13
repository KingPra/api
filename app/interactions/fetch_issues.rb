class FetchIssues
  include Interactor

  def call
    return unless context.repo
    sawyer_issues = fetch_issues(context.repo)
    context.issues = sawyer_issues.to_a.map(&:to_h)
  end

  private

  def gh_token
    ENV.fetch("GITHUB_API_TOKEN")
  end

  # def repos
  #   @repos ||= jr_devs_repos + authorized_challenge_repos
  # end
  #
  # def jr_devs_repos
  #   @jr_devs_repos ||= client.repositories("charlottejuniordevs").map(&:full_name)
  # end
  #
  # def authorized_challenge_repos
  #   @authorized_challenge_repos ||= YAML.load_file("config/authorized_challenge_repos.yml")
  # end

  def fetch_issues(url)
    issues = client.issues(url)

    last_response = client.last_response
    until last_response.rels[:next].nil?
      last_response = last_response.rels[:next].get
      issues += last_response.data
    end

    issues.reject(&:pull_request)
  end

  # def build_attrs(issue, repo)
  #   {
  #     repo:            repo,
  #     github_issue_id: issue.id,
  #     url:             issue.html_url,
  #     title:           issue.title,
  #     body:            issue.body,
  #     state:           issue.state,
  #     labels:          issue.labels.map(&:name)
  #   }
  # end

  def client
    @client ||= Octokit::Client.new(access_token: gh_token)
  end

  # def challenges
  #   context.challenges ||= []
  # end
end
