describe 'A text template' do
  before :each do
    @template = ReTemplate::Text.new
  end
  
  describe 'with a set of simple regexes' do
    before :each do
      @template.expressions = {
        /\{foo\}/ => :foo,
        /\{bar\}/ => :bar
      }
    end
    
    it 'should parse a simple string' do
      @template.parse! 'A {foo} is not a {bar}.'
    end
    
    describe 'and a simple string' do
      before :each do
        @template.parse! 'A {foo} is not a {bar}.'
      end
      
      it 'should render properly' do
        result = @template.render :foo => 'plant', :bar => 'rhinocerous'
        result.should == 'A plant is not a rhinocerous.'
      end
      
      it 'should discard any fields not found' do
        result = @template.render :foo => 'frog', :bar => 'spider', :something_else => 'should not render'
        result.should == 'A frog is not a spider.'
      end
      
      it 'should replace text verbatim, without further replacing it' do
        result = @template.render :foo => '{foo}{bar}', :bar => '{bar}{foo}'
        result.should == 'A {foo}{bar} is not a {bar}{foo}.'
        result = @template.render :foo => '{foo}', :bar => '{bar}'
        result.should == 'A {foo} is not a {bar}.'
        result = @template.render :foo => '{bar}', :bar => '{foo}'
        result.should == 'A {bar} is not a {foo}.'
      end
    end
    
    it 'should allow stranger expressions' do
      @template.expressions[/e(nter|xit)ed/] = :doorsign
      @template.parse! '{foo} exited the {bar} and entered the world!'
      result = @template.render :foo => 'Elvis', :bar => 'building', :doorsign => 'has left'
      result.should == 'Elvis has left the building and has left the world!'
    end
  end
  
  it 'should render a simple set of text matches' do
    @template.add_text_expressions 'foo', '{bar}' => :bar
    @template.parse! 'When a foo becomes a {bar}...'
    result = @template.render 'foo' => 'caterpillar', :bar => 'butterfly'
    result.should == 'When a caterpillar becomes a butterfly...'
  end
end