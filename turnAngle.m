function angle = turnAngle(first,current,next)

first = first';
current = current';
next = next';
v1 = current - first;
v2 = next - current;
angle=radtodeg(atan2(det([v1,v2]),dot(v1,v2)));