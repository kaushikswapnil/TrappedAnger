float g_DefaultNodeMass = 1.0f;
float g_DefaultNodeSize = 20.0f;

float g_IdealNodeDistance = 100.0f;
float g_NodeSpringConstant = 0.2f;
float g_NodeSpringFrictionCoeff = 0.05f;

Curve g_Curve;

void setup()
{
  size(800, 800);
  
  g_Curve = new Curve();
  g_Curve.m_Nodes.add(new CurveNode(new PVector(width/2, height/2)));
  g_Curve.m_Nodes.add(new CurveNode(new PVector(width/3, height/2)));
  g_Curve.m_Nodes.add(new CurveNode(new PVector(width/2, height/3)));
  g_Curve.m_Nodes.add(new CurveNode(new PVector(width/3, height/3)));
  
  //frameRate(1);
  
  background(255);
}

void draw()
{
  fill(0,10);
  rect(0,0,width,height);
  stroke(255);
  strokeWeight(5);
  for (int iter = 0; iter < (g_Curve.m_Nodes.size()+1)/2; ++iter)
   {
    CurveNode node = g_Curve.m_Nodes.get(iter);    
    
    for (CurveNode otherNode : g_Curve.m_Nodes)
    {
     line(node.m_Position.x, node.m_Position.y, otherNode.m_Position.x, otherNode.m_Position.y); 
    }
    
   }
  //g_Curve.Display();
  g_Curve.Update();
  
  float chanceToAddNewNode = 0.004 * (10 - g_Curve.m_Nodes.size());
  if (chanceToAddNewNode < 0.0)
  {
   chanceToAddNewNode = 0.004; 
  }
  
  if (random(1.0) < chanceToAddNewNode)
  {   
   CurveNode newNode = new CurveNode(new PVector(random(width), random(height)));
   g_Curve.m_Nodes.add(newNode);
  }
  
  float chanceToRemoveNode = 0.003 * g_Curve.m_Nodes.size();
  if (chanceToRemoveNode < 0.0)
  {
   chanceToRemoveNode = 0.003; 
  }
  if (g_Curve.m_Nodes.size() > 3 && random(1.0) < chanceToRemoveNode)
  {
    int randNode = (int)random(g_Curve.m_Nodes.size());
    g_Curve.m_Nodes.remove(randNode);
  }
}
