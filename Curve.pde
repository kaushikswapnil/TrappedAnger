class Curve
{
  ArrayList<CurveNode> m_Nodes;
  
  Curve(ArrayList<CurveNode> initialConfiguration)
  {
    m_Nodes = initialConfiguration;
  }
  
  Curve()
  {
    m_Nodes = new ArrayList<CurveNode>(); 
  }
    
  void Display()
  {
   for (CurveNode node : m_Nodes)
   {
     node.Display();
   }
  }
  
  void Update()
  {
    
   for (int iter = 0; iter < m_Nodes.size(); ++iter)
   {
    CurveNode node = m_Nodes.get(iter);    
    if (iter < (m_Nodes.size() + 1)/2)
    {
      for (CurveNode otherNode : m_Nodes)
      {
       if (otherNode != node)
       {
        float distNodes = node.m_Position.dist(otherNode.m_Position);
        PVector disp = PVector.sub(otherNode.m_Position, node.m_Position);
        disp.normalize();
        float distDifference = g_IdealNodeDistance - distNodes;
        PVector springForce = PVector.mult(disp, -g_NodeSpringConstant*distDifference);
        node.AddForce(springForce);
        otherNode.AddForce(PVector.mult(springForce, -1));
        
        if (node.m_Position.y <= 0.0)
        {
          node.AddForce(new PVector(0, 10));
        }
        else if (node.m_Position.y >= height)
        {
          node.AddForce(new PVector(0, -10));
        }
        
        if (node.m_Position.x <= 0.0)
        {
          node.AddForce(new PVector(10, 0));
        }
        else if (node.m_Position.x >= width)
        {
          node.AddForce(new PVector(-10, 0));
        }
        
        if (otherNode.m_Position.y <= 0.0)
        {
          otherNode.AddForce(new PVector(0, 10));
        }
        else if (otherNode.m_Position.y >= height)
        {
          otherNode.AddForce(new PVector(0, -10));
        }
        
        if (otherNode.m_Position.x <= 0.0)
        {
          otherNode.AddForce(new PVector(10, 0));
        }
        else if (otherNode.m_Position.x >= width)
        {
          otherNode.AddForce(new PVector(-10, 0));
        }
       }
      }
    }
    
    node.PhysicsFrame();   
   }
  }
}
