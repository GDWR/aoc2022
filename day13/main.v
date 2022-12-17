import os
import strconv


type Element = i64 | []Element

fn (self Element) compare(other Element) bool {
    println('- Compare $self vs $other')

    return match self {
        i64 {
            match other {
                i64 {self <= other}
                []Element { 
                    mut new_self := []Element{}
                    new_self << self
                    Element(new_self).compare(other)
                }
            }
        }
        []Element {
            match other {
                i64 {
                    mut new_other := []Element{}
                    new_other << other
                    Element(self).compare(new_other)
                }
                []Element {
                    if self.len < other.len {
                        return false
                    }

                    for i, e1 in self {
                        
                        if i > other.len - 1 {
                            return false
                        }
                        if e1.compare(other[i]) == false {
                            return false
                        }
                    }
                    
                    true
                }
            }
        }
    }
}


struct PacketIterator {
    packet string
mut:
    p int
}

fn (mut self PacketIterator) next() ?Element {
    start := self.p
    self.p++

    if self.p >= self.packet.len {
        return none
    }

    mut nest := 0

    for {
        if self.p >= (self.packet.len - 1) { 
            break
        } 

        match self.packet[self.p] {
            `[` {nest++}
            `]` {nest--}
            `,` {if nest==0 {break}}
            else {}
        }   

        self.p++
    }

    raw := self.packet[1+start..self.p]
    if raw == "" {
        return none
    }

    return strconv.parse_int(raw, 10, 0) or {
        mut iter := PacketIterator{packet: raw}
        return iter.collect()
    }
}

fn (mut self PacketIterator) collect() []Element {
    mut out := []Element{}

    for element in self {
        out << element
    }

    return out
}

fn main() {
    
    lines := os.read_lines('data')!
    
    mut part_one := 0
    mut i := 0
    for (i <= lines.len) {
        println('== Pair ${(i/3) + 1} ==')
        mut p1 := PacketIterator{packet: lines[i]}
        mut p2 := PacketIterator{packet: lines[i+1]}
        mut right_order := true 
        for {
            v1 := p1.next() or {break}
            v2 := p2.next() or {
                right_order = false
                break
            }          
            
            result := v1.compare(v2)
            if result == false {
                right_order = false
                break
            }
        }
        
        if right_order {
            part_one += (i/3) + 1
        }
        println(' Ordered: $right_order\n')
        i += 3
    }
    
    println('Partone: $part_one')
}
