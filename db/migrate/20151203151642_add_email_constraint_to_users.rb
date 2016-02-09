class AddEmailConstraintToUsers < ActiveRecord::Migration
	def up
		execute %{
			ALTER TABLE
				users
			ADD CONSTRAINT 
				email_must_be_company_email
			CHECK ( email ~* '^[^@]+@delzell\\.net' )

		}
		
	end
	def down
		execut %{
			ALTER TABLE
				users
			DROP CONSTRAINT
				email_must_be_company_email
		}
		
	end
end
