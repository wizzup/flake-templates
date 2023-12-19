module LibSpec where

import Test.Hspec
import Lib

spec :: Spec
spec = describe "Lib.func" $ do
  it "returns correct result" $
    Lib.func "World" `shouldBe` "Hello World"

main :: IO ()
main = hspec spec
