class Meta<Sequel::Model(DB[:site_metas])
      plugin :uuid, :field => :id

      def self.config_meta(params)
          existing=Meta.first
          if(!existing)
              existing=Meta.create(params)
          else
            existing.update(params)
          end
          existing
      end

end
