# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  label      :string(255)
#  content    :text(255)
#  summary    :text(255)
#  publish    :boolean
#  frontpage  :boolean
#  menu       :string(255)
#  rank       :integer          default(5)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author     :string(255)
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
