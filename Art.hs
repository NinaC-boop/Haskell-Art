module Art where  

import ShapeGraphics
import Codec.Picture

art :: Picture
art = dreamcatcher (Point 400 400) 20 200 white 10

tree :: Int -> Point -> Vector -> Colour -> Picture
tree depth base direction colour
  | depth == 0 = drawLine line
  | otherwise
    =  drawLine line
    ++ tree (depth - 1) nextBase left nextColour -- left tree
    ++ tree (depth - 1) nextBase right nextColour -- left tree
  where
    drawLine :: Line -> Picture
    drawLine (Line start end) =
      [ Path [start, end] colour Solid ]

    line = Line base nextBase
    nextBase = offset direction base

    left = rotate (-pi /12) $ scale 0.8 $ direction
    right = rotate (pi /12) $ scale 0.8 $ direction

    nextColour =
      colour { redC = (redC colour) - 24, blueC = (blueC colour) + 24 }

-- 1. recursive function
-- 2. more parameters that's not depth, size, colour
-- 3. make it realllly pretty

-- writeToFile art

-- also takes in number of circles and amount of glow
dreamcatcher :: Point -> Float -> Float -> Colour -> Float -> Picture
dreamcatcher center circles radius colour glow
  | circles == 1 = [drawCircle (Point 400 400) radius colour] 
                 ++ (map net (angles circles))
  | otherwise = [drawCircle (Point 400 400) radius colour] 
              ++ (map net (angles circles))
              ++ (map (drawGlow radius colour) glowCircles)
              ++ dreamcatcher center (circles-1) (radius/2) (nextColour (circles - 1)) glow
  where
    angles :: Float -> [Float]
    angles n = [0, pi/n .. 2*(n-1)*pi/n]

    drawCircle :: Point -> Float -> Colour -> PictureObject
    drawCircle center radius colour = Circle center radius colour Solid NoFill

    net :: Float -> PictureObject
    net angle = drawCircle (findCenter angle) (radius/2) (nextAngleColour angle (nextColour circles)) where
      -- takes in an angle and returns point of center for circle
      findCenter :: Float -> Point
      findCenter angle = Point (400 + ((radius/2)*cos(angle))) (400 + ((radius/2)*sin(angle)))

    scale :: Float
    scale = 20
      
    nextColour :: Float -> Colour
    nextColour circles = colour { redC = ((redC colour) + 100 - round(circles*scale)),
                                  greenC = ((greenC colour) + 250 - round(circles*scale)), 
                                  blueC = ((blueC colour) + 100 - round(circles*scale)), 
                                  opacityC = ((opacityC colour) - round(circles*10)) }

    nextAngleColour :: Float -> Colour -> Colour
    nextAngleColour angle colour = colour { redC = ((redC colour) + round(cos(angle)*scale)), 
                                            greenC = ((greenC colour) - round(sin(angle)*scale)), 
                                            blueC = ((blueC colour) - round(cos(angle)*scale)),
                                            opacityC = ((opacityC colour) - round(cos(angle)*2)) }
    
    drawGlow :: Float -> Colour -> Float -> PictureObject
    drawGlow radius colour n = Circle (Point 400 400) (radius + n) nextRingColour Solid NoFill where
      nextRingColour :: Colour
      nextRingColour = 
        colour { opacityC = round(n) - round(n/5) }

    glowCircles :: [Float]
    glowCircles = [0, 1 .. glow]

-- Offset a point by a vector
offset :: Vector -> Point -> Point
offset (Vector vx vy) (Point px py)
  = Point (px + vx) (py + vy)

-- Scale a vector
scale :: Float -> Vector -> Vector
scale factor (Vector x y) = Vector (factor * x) (factor * y)

-- Rotate a vector (in radians)
rotate :: Float -> Vector -> Vector
rotate alpha (Vector vx vy)
  = Vector (cos alpha * vx - sin alpha * vy)
           (sin alpha * vx + cos alpha * vy)

-- use 'writeToFile' to write a picture to file "ex01.png" to test your
-- program if you are not using Haskell for Mac
-- e.g., call
-- writeToFile [house, door]

writeToFile pic
  = writePng "art.png" (drawPicture 3 art)

  