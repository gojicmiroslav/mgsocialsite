class MicropostsController < ApplicationController
	
	before_action :authenticate_user!, only: [:create, :destroy]
	before_action :correct_user, only: :destroy

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_to root_url
		else
			@feed_items = []
			render "static_pages/home"
		end
	end

	def destroy
		@micropost.destroy
		flash[:success] = "Micropost deleted."
		# posto se postovi prikazuju na dve stranice(home i pofile) i brisanje se moze izvrsiti na ove dve stranice.
		# Ispitujemo sa koje stranice se vrsi brisanje i preusmeravamo(redirect) ponovo na tu stranicu.
		# Ukoliko je request.referrer nil preusmeravamo na root_url. Ovo se u stvari nikada nece desiti jer
		# request.referrer ce uvek biti makar home page, ovo je samo zbog testiranja, ako je slucajno
		# request.referrer negde nil. 
		redirect_to request.referrer || root_url
	end

	private 

	def micropost_params
		params.require(:micropost).permit(:content, :picture)
	end

	def correct_user
		@micropost = current_user.microposts.find_by(id: params[:id])
		redirect_to root_url if @micropost.nil?
	end
end
