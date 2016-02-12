require 'test_helper'

class TicketsControllerTest < ActionController::TestCase
  setup do
    @ticket = tickets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tickets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ticket" do
    assert_difference('Ticket.count') do
      post :create, ticket: { asignat_operator: @ticket.asignat_operator, data_reclamatie: @ticket.data_reclamatie, id_departament: @ticket.id_departament, in_lucru: @ticket.in_lucru, in_lucru_data: @ticket.in_lucru_data, obs: @ticket.obs, prioritate: @ticket.prioritate, reclamatia: @ticket.reclamatia, rezolvat: @ticket.rezolvat, rezolvat_data: @ticket.rezolvat_data, rezolvat_operator: @ticket.rezolvat_operator, status: @ticket.status, user_reclamatie: @ticket.user_reclamatie }
    end

    assert_redirected_to ticket_path(assigns(:ticket))
  end

  test "should show ticket" do
    get :show, id: @ticket
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ticket
    assert_response :success
  end

  test "should update ticket" do
    patch :update, id: @ticket, ticket: { asignat_operator: @ticket.asignat_operator, data_reclamatie: @ticket.data_reclamatie, id_departament: @ticket.id_departament, in_lucru: @ticket.in_lucru, in_lucru_data: @ticket.in_lucru_data, obs: @ticket.obs, prioritate: @ticket.prioritate, reclamatia: @ticket.reclamatia, rezolvat: @ticket.rezolvat, rezolvat_data: @ticket.rezolvat_data, rezolvat_operator: @ticket.rezolvat_operator, status: @ticket.status, user_reclamatie: @ticket.user_reclamatie }
    assert_redirected_to ticket_path(assigns(:ticket))
  end

  test "should destroy ticket" do
    assert_difference('Ticket.count', -1) do
      delete :destroy, id: @ticket
    end

    assert_redirected_to tickets_path
  end
end
