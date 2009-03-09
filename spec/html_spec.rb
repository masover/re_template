module HtmlSpec
  class BeDoc < Test::Spec::CustomShould
    def docify string
      Nokogiri::HTML.parse(string.to_s).to_s
    end
    def assumptions other
      docify(other).should == docify(object)
    end
  end
  def be_doc doc
    BeDoc.new doc
  end
end

describe 'An HTML template' do
  include HtmlSpec

  before :each do
    @template = ReTemplate::Html.new
  end
  
  describe 'with a set of simple regexes' do
    include HtmlSpec
    before :each do
      @template.expressions = {
        /\{foo\}/ => :foo,
        /\{bar\}/ => :bar
      }
    end
    
    it 'should parse a simple document' do
      @template.parse! '<p>A {foo} is not a {bar}.</p>'
    end
    
    describe 'and a simple string' do
      include HtmlSpec
      before :each do
        @template.parse! '<p>A {foo} is not a {bar}.</p>'
      end
      
      it 'should render properly' do
        result = @template.render :foo => 'plant', :bar => 'rhinocerous'
        result.should be_doc('<p>A plant is not a rhinocerous.</p>')
      end
      
      it 'should discard any fields not found' do
        result = @template.render :foo => 'frog', :bar => 'spider', :something_else => 'should not render'
        result.should be_doc('<p>A frog is not a spider.</p>')
      end
      
      it 'should replace text verbatim, without further replacing it' do
        result = @template.render :foo => '{foo}{bar}', :bar => '{bar}{foo}'
        result.should be_doc('<p>A {foo}{bar} is not a {bar}{foo}.</p>')
        result = @template.render :foo => '{foo}', :bar => '{bar}'
        result.should be_doc('<p>A {foo} is not a {bar}.</p>')
        result = @template.render :foo => '{bar}', :bar => '{foo}'
        result.should be_doc('<p>A {bar} is not a {foo}.</p>')
      end
    end
  end
  
  it 'should render a simple set of text matches' do
    @template.add_text_expressions 'foo', '{bar}' => :bar
    @template.parse! '<p>When a foo becomes a {bar}...</p>'
    result = @template.render 'foo' => 'caterpillar', :bar => 'butterfly'
    result.should be_doc('<p>When a caterpillar becomes a butterfly...</p>')
  end
  
  it 'should ignore expressions that straddle text nodes' do
    @template.add_text_expressions 'foo'
    @template.parse! '{fo<i>o}</i>'
    result = @template.render :foo => 'bar'
    result.should be_doc('{fo<i>o}</i>')
  end
  
  it 'should escape substituted values' do
    @template.add_text_expressions '{foo}' => :foo
    @template.parse! '<p>{foo}</p>'
    result = @template.render :foo => '<example>'
    result.should be_doc('<p>&lt;example&gt;</p>')
  end
  
  it 'should match escaped text in template' do
    @template.add_text_expressions '<foo>' => :foo
    @template.parse! '<p>&lt;foo&gt;</p>'
    result = @template.render :foo => 'bar'
    result.should be_doc('<p>bar</p>')
  end
  
  it "shouldn't match tags" do
    @template.add_text_expressions '<foo>' => :foo
    @template.parse! '<p><foo></foo></p>'
    result = @template.render :foo => 'bar'
    result.should be_doc('<p><foo></foo></p>')
  end
end