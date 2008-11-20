class School < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :geo
  belongs_to :county
  has_one    :basic,   :class_name => "SchoolBasic"
  has_one    :traffic, :class_name => "SchoolTraffic"
  has_one    :need,    :class_name => "SchoolNeed"
  has_one    :contact, :class_name => "SchoolContact"
  has_one    :local,   :class_name => "SchoolLocal"
  has_one    :finder,  :class_name => "SchoolFinder"
  
  validates_presence_of :title
  
  
  def self.categories
    %w(小学 中学 四川灾区板房学校)
  end
  
  def school_basic=(basic_attributes)
    if basic_attributes[:id].blank?
      build_basic(basic_attributes)
    else
      basic.attributes = basic_attributes
    end
  end
  
  def school_traffic=(traffic_attributes)
    if traffic_attributes[:id].blank?
      build_traffic(traffic_attributes)
    else
      traffic.attributes = traffic_attributes
    end
  end
 
  def school_need=(need_attributes)
    if need_attributes[:id].blank?
      build_need(need_attributes)
    else
      need.attributes = need_attributes
    end
  end
  
  def school_contact=(contact_attributes)
    if contact_attributes[:id].blank?
      build_contact(contact_attributes)
    else
      contact.attributes = contact_attributes
    end
  end
  
  def school_local=(local_attributes)
    if local_attributes[:id].blank?
      build_local(local_attributes)
    else
      local.attributes = local_attributes
    end
  end
  
  def school_finder=(finder_attributes)
    if finder_attributes[:id].blank?
      build_finder(finder_attributes)
    else
      finder.attributes = finder_attributes
    end
  end
  
end