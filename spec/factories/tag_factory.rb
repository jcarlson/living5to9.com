Factory.sequence :tag_term do |n|
  "term #{n}"
end

Factory.define :tag do |t|
  t.term { Factory.next :tag_term }
end