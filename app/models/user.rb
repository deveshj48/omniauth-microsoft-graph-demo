class User < ApplicationRecord
  devise :rememberable, :omniauthable, omniauth_providers: %i[microsoft_graph]

  def self.from_omniauth_microsoft_graph(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.extra.raw_info.mail
      user.name = auth.extra.raw_info.displayName
    end
  end
end
