###
# Description
#
# Datafields:
# - height: stored as cm - max ~30 ft (see migration)
# - weight: stored as kg - max ~2,200 lbs (see migration)
###

require_dependency 'units'

class PreopRiskAssessment < ActiveRecord::Base
  extend HasBitField

  belongs_to :surgical_profile

  # Bit field variables
  # IMPORTANT - 'has-bit-field' gem
  # - Max of 31 bit field attributes
  # - Order must be maintained, any new bit fields added at end of
  #   this definition list
  #
  has_bit_field :bit_field,
    :current_smoker_within_1yr,
    :dyspnea_1yr,
    :ventilator_dependent_within_48hrs,
    :history_of_severe_copd,
    :ascites_within_30days,
    :chf_within_30days,
    :hypertension_requiring_medications,
    :acute_renal_failure,
    :requiring_dialysis_within_2wks,
    :dis_ca,
    :open_wound,
    :steriod_or_immunosuppressant_for_chronic,
    :significant_body_weight_loss_last_6mos,
    :bleeding_disorders,
    :preop_transfusion_rbc_within_72hrs,
    :gerd_meds_within_30days,
    :gallstone_disease,
    :ambulation_limited,
    :activity_limited_by_pain,
    :requires_daily_medication,
    :surgical_intervention_planned_or_performed

  # Non-DB attributes for front end logic
  attr_accessor :patient_id

  # Static class variables

  # IMPORTANT: do not change order of array constants, only append;
  # values tied to database entries indexed according to order
  @@DIABETES_MELLITUS_OPTIONS = [
    'Non-Insulin',
    'Insulin',
    'No'
    ]
  @@FUNCTIONAL_HEALTH_OPTIONS = [
    'I',
    'PD',
    'TD',
    'Unknown'
    ]
  @@SEPSIS_WITHIN_48HRS_OPTIONS = [
    'SIRS',
    'SEPSIS',
    'Sep Shock'
    ]

  ###
  # Static methods
  ###
  def self.query_all_by_surgical_profile(surgeon, surgical_profile)
    if surgeon.is_admin()
      return PreopRiskAssessment.joins(:surgical_profile)
        .where(surgical_profile: surgical_profile)
    else
      return PreopRiskAssessment.joins(:surgical_profile)
        .where(surgical_profile: surgical_profile)
        .where(surgical_profiles: {user_id: surgeon.id})
    end
  end

  def self.query_one_by_id(surgeon, id)
    if surgeon.is_admin()
      return PreopRiskAssessment.find(id)
    else
      return PreopRiskAssessment.joins(:surgical_profile)
              .where(surgical_profiles: {user_id: surgeon.id})
              .where(preop_risk_assessments: {id: id})
              .first
    end
  end

  # return static constants arrays
  def self.get_diabetes_mellitus_options
    return @@DIABETES_MELLITUS_OPTIONS
  end

  def self.get_functional_health_options
    return @@FUNCTIONAL_HEALTH_OPTIONS
  end

  def self.get_sepsis_within_48hrs_options
    return @@SEPSIS_WITHIN_48HRS_OPTIONS
  end

  # return static constant array strings by index
  def self.get_diabetes_mellitus_option_by_index(index)
    if index.between?(0, @@DIABETES_MELLITUS_OPTIONS.length - 1)
      return @@DIABETES_MELLITUS_OPTIONS[index]
    end
    return ''
  end
  def self.get_functional_health_option_by_index(index)
    if index.between?(0, @@FUNCTIONAL_HEALTH_OPTIONS.length - 1)
      return @@FUNCTIONAL_HEALTH_OPTIONS[index]
    end
    return ''
  end
  def self.get_sepsis_within_48hrs_option_by_index(index)
    if index.between?(0, @@SEPSIS_WITHIN_48HRS_OPTIONS.length - 1)
      return @@SEPSIS_WITHIN_48HRS_OPTIONS[index]
    end
    return ''
  end

  # return static constant nested arrays for selector that includes
  #   select option value and text
  # - [['Non-Insulin' ,0], ['Insulin', 1] -> text is mapped to index
  #   in the static constants array
  def self.get_diabetes_mellitus_options_select
    return self.get_diabetes_mellitus_options.map.with_index{|x,i| [x,i]}
  end

  def self.get_functional_health_options_select
    return self.get_functional_health_options.map.with_index{|x,i| [x,i]}
  end

  def self.get_sepsis_within_48hrs_options_select
    return self.get_sepsis_within_48hrs_options.map.with_index{|x,i| [x,i]}
  end


  ###
  # Instance methods
  ###

  def height_ft_str
    return Units.cm_to_ft(height).round(1).to_s + ' ft'
  end

  def weight_lb_str
    return Units.kg_to_lb(weight).round(1).to_s + ' lbs'
  end

  def body_mass_index_eng_str
    # calculate body_mass_index from height and weight
    eng_weight = Units.kg_to_lb(weight)
    eng_height = Units.cm_to_ft(height)
    return (eng_weight / (eng_height ** 2)).round(1).to_s + ' lb/ft'
  end

end
