local addonName, addon = ...

local importString =
"!nE12UXjmq0pOQUIXgBSFnQs9onQKNrz3GjLw6s1gOn9L8TxaFzgdoQrrISRX(4ZCMZm2BnuFtD1WPVBUB8H5pwchYwg5C9v1vn(bQaO4aVUKT85xZYkoKxxYN)Y6BlZNFCvDPy5Tx1pm00p9Wy9YFRRibCs5biahpFb70W95UZnpDB1WW43mwe5jrKX1h0EeHISdSxoI5jrKl5iICH45rCtilscNubhuHqwjxW(fbNmjC56CmHW5zly)cJ3XzC6AB7UBQF8VZqOwM1FmMF4wWVp2pzw2Y7MUCXCE8ntNV3mC(9npod86KFW0pBx6goppRXW8UEQV3XUrJ5NDNVVUmB5Bx6Ah)sB7dMvh28c(18mjMnxiAP(YJGVz9F(HSj(nrP9XcVTVybQ1vfYRLfHPPcZvhwaKfWdaYIfooTYa26YboHnoQd54yv3n0pCPUQTLBABjrbqIp((4JVp(errqkYldKhjBisd2gCvi9wiN2q2ra2R)Cc)ubXs7I9mcVGiQkqH0Yq2EgkDOWiuCVcYneyzzukgYtLGetKyEgebTYM)Suz9DfyMufetnvmbVSKYz4aK4hCzpqS1q4ObHNAKNk3QuUvPOwlxqd6auRXVfkwWgvYqUWO2gWL8zixycI3ELclVNMIq7H25EfP0EfgtyrKLE5i9ei9Kb6r02cuuuOOOd7avqZiLPaMcCpHnczuojpkNqsko4ISOEvdOLrEPYLG4yGBb1g5GyJ9T9K1(ktiH2SInxILw2eK9vAucLX6Me3)cmMuOEOjrxgoaq9CrT2CHehD1yhvqqftVsiXDVaNQcRZ00nJwa72gRfXPFSaAmoT5GERfoUbMvElsjVHh84tfWYFrq0E2xWb8ycgQM8T9iOEQD6jKNQ3qbUe5gZl90Ry7ipPDmJyhj9j0evwIQ86IJBYAphqLqg5fOoIUuo6t4KtELbTKlsuOBzLkWQr3)VXBpJZ5a2nbGuLZm0XbKE)UYCjjLS)KpBRn3oX3EYh6EgDvN3K0cn6Qs9N45IAEgTmDJARD9e8NEYLjDT5rhyYdH0OtY3CUlxqObYualRcAFEWB4P7l4KU)B7bgPvQZZvq8Ck0NJPb)9J838isk4bgSHMHRGS9crfXYdENGI9xOtroJXtOJGVHI)ojreYR(f07Ksehir2bVbsECEsI6jPrGcLwnPxc9qpmJcykfqnX5(Z21Dre1CH)mxv1xWMZ2DzWDxCeVZF10PEZVn9HPoAEC(5xp21yUC49F5PBV(t3C9t3(kMQU6NnDl)SI2lgZ3g6B(Wq3ztt9jCe3VE4K5(PU(1F)Gd1PUM6Q39z5XJvF6Xh)4BNhR(Fa"

local function testFunc()
  local frame = MDT.main_frame
  frame.sidePanelImportButton.frame:Click()
  C_Timer.After(0.5, function()
    frame.presetImportBox:SetText(importString)
    frame.presetImportBox:HighlightText()
    frame.presetImportBox.OnTextChanged(nil, nil, importString)
    C_Timer.After(0.5, function()
      frame.presetImportButton.frame:Click()
    end)
  end)
end

---@type MDTTest
local test = {
  name = "Import Route",
  func = testFunc,
  duration = 2
}

tinsert(addon.test.testList, test)
