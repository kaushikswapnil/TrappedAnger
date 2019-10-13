float g_DefaultNodeMass = 1.0f;
float g_DefaultNodeSize = 20.0f;

float g_IdealNodeDistance = 110.0f;
float g_NodeSpringConstant = 0.08f;
float g_NodeSpringFrictionCoeff = 0.02f;

float g_BackgroundAlpha = 7.0;

int g_RectSpaceBuffer = 5;

int g_ColorMode;

int g_StrokeWeight = 6;

float g_MinChanceOfNodeIncrease = 0.0005;
float g_MaxChanceOfNodeIncrease = 0.01;
float g_MinChanceOfNodeDecrease = 0.0004;
float g_MaxChanceOfNodeDecrease = 0.01;

Curve g_Curve;

void setup()
{
  size(800, 800);
  g_ColorMode = 0;
  
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
  fill(0,g_BackgroundAlpha);
  rect(-g_RectSpaceBuffer,-g_RectSpaceBuffer,width+2*g_RectSpaceBuffer,height+2*g_RectSpaceBuffer);
  pushMatrix();
  
  if (g_ColorMode == 1) //HSB
  {     
    colorMode(HSB, 100);
    //float hueFloat = map(noise(xFlowMove, yFlowMove, zFlowMove), 0.0, 1.0, 0, 100);
    //stroke(hueFloat, 100, 100);
    
    int hueInt = (frameCount)%100;
    stroke(hueInt, 100, 100);
  }
  else //RGB
  {
    colorMode(RGB, 255);
    
    textAlign(CENTER);
    fill(255);
    text("Press space to change the color mode.", width/2, 10);
    
    stroke(255); 
  }
  
  strokeWeight(g_StrokeWeight);
  for (int iter = 0; iter < (g_Curve.m_Nodes.size()+1)/2; ++iter)
   {
    CurveNode node = g_Curve.m_Nodes.get(iter);    
    
    for (CurveNode otherNode : g_Curve.m_Nodes)
    {
     line(node.m_Position.x, node.m_Position.y, otherNode.m_Position.x, otherNode.m_Position.y); 
    }
    
   }
  //g_Curve.Display();
  popMatrix();
  g_Curve.Update();
  
  float chanceToAddNewNode = 0.002 * (10 - g_Curve.m_Nodes.size());
  if (chanceToAddNewNode < g_MinChanceOfNodeIncrease)
  {
   chanceToAddNewNode = g_MinChanceOfNodeIncrease; 
  }
  else if (chanceToAddNewNode > g_MaxChanceOfNodeIncrease)
  {
   chanceToAddNewNode = g_MaxChanceOfNodeIncrease; 
  }
  
  if (random(1.0) < chanceToAddNewNode)
  {   
   CurveNode newNode = new CurveNode(new PVector(random(width), random(height)));
     g_Curve.m_Nodes.add(newNode);
  }
  
  float chanceToRemoveNode = 0.001 * g_Curve.m_Nodes.size();
  if (chanceToRemoveNode < g_MinChanceOfNodeDecrease)
  {
   chanceToRemoveNode = g_MinChanceOfNodeDecrease; 
  }
  else if (chanceToRemoveNode > g_MaxChanceOfNodeDecrease)
  {
   chanceToRemoveNode = g_MaxChanceOfNodeDecrease; 
  }
  else
  if (g_Curve.m_Nodes.size() > 3 && random(1.0) < chanceToRemoveNode)
  {
    int randNode = (int)random(g_Curve.m_Nodes.size());
    g_Curve.m_Nodes.remove(randNode);
  }
}

void keyPressed()
{
   if (key == ' ')
   {
      g_ColorMode = (g_ColorMode + 1) % 2; 
   }
}
