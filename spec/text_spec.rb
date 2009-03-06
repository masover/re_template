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
      
      it 'Should render properly' do
        result = @template.render :foo => 'plant', :bar => 'rhinocerous'
        result.should == 'A plant is not a rhinocerous.'
      end
      
      it 'Should discard any fields not found' do
        result = @template.render :foo => 'frog', :bar => 'spider', :something_else => 'should not render'
        result.should == 'A frog is not a spider.'
      end
    end
    
    it 'should allow stranger expressions' do
      @template.expressions[/e(nter|xit)ed/] = :doorsign
      @template.parse! '{foo} exited the {bar} and entered the world!'
      result = @template.render :foo => 'Elvis', :bar => 'building', :doorsign => 'has left'
      result.should == 'Elvis has left the building and has left the world!'
    end
  end
end