class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :codewars_handle,
             :credibility,
             :first_name,
             :github_handle,
             :last_name,
             :linkedin_url,
             :resume_site_url,
             :stackoverflow_url,
             :twitter_handle,
             :picture
end
