class CurveNode
{
 PVector m_Position;
 PVector m_Acceleration;
 PVector m_Velocity;
 float m_Mass;
 
 CurveNode(PVector position)
 {
   m_Position = position;
   
   m_Acceleration = new PVector(0, 0);
   m_Velocity = new PVector(0, 0);
   
   m_Mass = g_DefaultNodeMass;
 }
 
 CurveNode(PVector position, float mass)
 {
   m_Position = position;
   
   m_Acceleration = new PVector(0, 0);
   m_Velocity = new PVector(0, 0);
   
   m_Mass = mass;
 }
 
 void AddForce(PVector force)
 {
  PVector acc = PVector.div(force, m_Mass);
  m_Acceleration.add(acc);
 }
 
 void PhysicsFrame()
 {
  AddFriction();
   
  m_Velocity.add(m_Acceleration);
  m_Acceleration.mult(0);
  
  m_Position.add(m_Velocity);
 }
 
 void Display()
 {
  float size = g_DefaultNodeSize * m_Mass;
  fill(255, 0, 0);
  ellipse(m_Position.x, m_Position.y, size, size); 
 }
 
 void AddFriction()
 {
  PVector velocityDir = m_Velocity.get();
  velocityDir.normalize();
  
  float velocityMag = m_Velocity.mag();
  
  PVector springFriction = PVector.mult(velocityDir, -velocityMag*g_NodeSpringFrictionCoeff);
  AddForce(springFriction);
 }
}
