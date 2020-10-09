# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'enum' do
    it { is_expected.to define_enum_for(:status).with_values(unpublish: 0, publish: 1) }
  end
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:another_user)
  end

  it 'has a valid factory of user' do
    user = @user
    expect(user).to be_valid
  end

  it 'has a valid factory of another_user' do
    user = @another_user
    expect(user).to be_valid
  end

  # カテゴリーの名前、ステータス、外部キー（user_id）があれば有効。
  it 'is valid with a name, status and user_id' do
    user = @user
    category = user.categories.build(
      name: 'テスト',
      status: 0,
      user_id: 1
    )
    expect(category).to be_valid
  end

  # カテゴリーの名前がなければ無効。
  it 'is invalid without name' do
    category = Category.new(name: nil)
    category.valid?
    expect(category.errors[:name]).to include("can't be blank")
  end

  # カテゴリーのステータスがなければ無効。
  it 'is invalid without status' do
    category = Category.new(status: nil)
    category.valid?
    expect(category.errors[:status]).to include("can't be blank")
  end

  # 外部キーがなければカテゴリーは無効。
  it 'is invalid without user_id' do
    category = Category.new(user_id: nil)
    category.valid?
    expect(category.errors[:user_id]).to include("can't be blank")
  end

  # 同一のユーザーは同一のカテゴリー名, 外部キーを有するカテゴリーを作成できない。
  it 'does not allow a single user to have categories which has the same name' do
    user = @user
    user.categories.create(
      name: 'テスト',
      user_id: 1
    )
    category = user.categories.build(
      name: 'テスト',
      user_id: 1
    )
    category.valid?
    expect(category.errors[:name]).to include('has already been taken')
  end

  # 異なるユーザーはそれぞれ同一の名前を持つカテゴリーを作成できる。
  it 'does allow each user to have an category which has the same name' do
    user = @user
    user.categories.create(
      name: 'テスト',
      user_id: 1
    )
    another_user = @another_user
    category = another_user.categories.build(
      name: 'テスト',
      user_id: 2
    )
    expect(category).to be_valid
  end
end
