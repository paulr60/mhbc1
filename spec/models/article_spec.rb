# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  label      :string(255)
#  content    :string(255)
#  summary    :string(255)
#  publish    :boolean
#  frontpage  :boolean
#  menu       :string(255)
#  rank       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Article do
    before do
		    @article = Article.new(title: "Example Article", label: "example",
						            content: "This is a very short article.")  
    end

    subject { @article }

    it { should respond_to(:title) }
    it { should respond_to(:label) }
    it { should respond_to(:summary) }
    it { should respond_to(:content) }
    it { should respond_to(:publish) }
    it { should respond_to(:frontpage) }
    it { should respond_to(:menu) }
    it { should respond_to(:rank) }

    it { should be_valid }

    describe "when title is not present" do
		before { @article.title = "" }
		it { should_not be_valid }
    end

end
