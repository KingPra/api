class FetchIssues
  include Interactor

  def call
    return unless context.repo.present?
    sawyer_issues = fetch_issues(context.repo)
    context.issues = sawyer_issues.to_a.map(&:to_h)
  end

  private

  def gh_token
    ENV.fetch("GITHUB_API_TOKEN")
  end

  def fetch_issues(url)
    issues = client.issues(url)

    last_response = client.last_response
    until last_response.rels[:next].nil?
      last_response = last_response.rels[:next].get
      issues += last_response.data
    end

    issues.reject(&:pull_request)
  end

  def client
    @client ||= Octokit::Client.new(access_token: gh_token)
  end
end
