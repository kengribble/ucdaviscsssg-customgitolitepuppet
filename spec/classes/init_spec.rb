require 'spec_helper'
describe 'customgitolitepuppet' do
  context 'with default values for all parameters' do
    it { should contain_class('customgitolitepuppet') }
  end
end
