module LifeSigns
  module Activity
    extend ActiveSupport::Concern

    included do
      belongs_to :actor, polymorphic: true
      belongs_to :content, polymorphic: true

      validates_associated :content

      default_scope { order('updated_at DESC').includes(:content) }
    end

    module ClassMethods
      def actors(actor_hash)
        where([actors_query(actor_hash.count), *actor_hash.to_a.flatten(1)])
      end

      private

      def actors_query(actors_count)
        ([actor_finder_sql] * actors_count).join(' OR ')
      end

      def actor_finder_sql
        '(actor_type = ? AND actor_id IN (?))'
      end
    end
  end
end
