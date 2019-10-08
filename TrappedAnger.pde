float g_DefaultNodeMass = 1.0f;
float g_DefaultNodeSize = 20.0f;

float g_IdealNodeDistance = 50.0f;
float g_NodeSpringConstant = 0.1f;
float g_NodeSpringFrictionCoeff = 0.01f;

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
  fill(255,20);
  rect(0,0,width,height);
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
  
  if (random(1.0) < 0.01 && g_Curve.m_Nodes.size() < 10)
  {
   CurveNode newNode = new CurveNode(new PVector(random(width), random(height)));
   g_Curve.m_Nodes.add(newNode);
  }
  else if (g_Curve.m_Nodes.size() > 3 && random(1.0) < 0.008f)
  {
    int randNode = (int)random(g_Curve.m_Nodes.size());
    g_Curve.m_Nodes.remove(randNode);
  }
}