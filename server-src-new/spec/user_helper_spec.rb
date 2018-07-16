require 'spec_helper'
require 'rails_helper'

class UserTestHelper
  include UserHelper
end

describe UserHelper do
  describe '.current_user_id' do
    context 'sets current user id to thread local' do
      it 'sets user id to thread local to 1' do
        user_test_helper = UserTestHelper.new
        user_test_helper.current_user_id = 1
        expect(user_test_helper.current_user.id).to eql(1)
      end
    end
  end


  describe '.compose_roles' do
    context 'sets the required flags to create role list' do
      it 'single role check' do
        user_test_helper = UserTestHelper.new
        user_test_helper.current_user_id = 1
        expect(user_test_helper.compose_roles(UserHelper::MODIFY_ORDERS)).to eql(UserHelper::MODIFY_ORDERS)
      end

      it 'multiple role check' do
        user_test_helper = UserTestHelper.new
        user_test_helper.current_user_id = 1
        roles = user_test_helper.compose_roles(UserHelper::MODIFY_ORDERS, UserHelper::MODIFY_HOTEL)
        expect(roles & UserHelper::MODIFY_ORDERS > 0).to be(true)
        expect(roles & UserHelper::MODIFY_HOTEL > 0).to be(true)
        expect(roles & UserHelper::MODIFY_DISHES > 0).to be(false)
        expect(roles & UserHelper::REPLY_TO_REVIEWS > 0).to be(false)
      end

      it 'role add remove check' do
        user_test_helper = UserTestHelper.new
        user_test_helper.current_user_id = 1
        # check adding all roles
        user_test_helper.add_roles(UserHelper::ROLES)
        UserHelper::ROLES.each { |role| expect(user_test_helper.has_permission(role)).to be(true) }
        # check permission after removing all roles
        user_test_helper.remove_roles(UserHelper::ROLES)
        UserHelper::ROLES.each { |role| expect(user_test_helper.has_permission(role)).to be(false) }
        # add random roles
        UserHelper::ROLES.each_with_index { |role, index| user_test_helper.add_roles(role) if index % 2 == 0 }
        UserHelper::ROLES.each_with_index { |role, index| expect(user_test_helper.has_permission(role)).to be(index % 2 == 0) }
      end
    end
  end
end