/**************************************************************************
 * LOGOSWARE Class Library.
 *
 * Copyright 2009 (c) LOGOSWARE (http://www.logosware.com) All rights reserved.
 *
 *
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation; either version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
 * Place, Suite 330, Boston, MA 02111-1307 USA
 *
 **************************************************************************/
package com.logosware.qr {
import app.TestAssets;

import flash.display.Bitmap;
import flash.display.BitmapData;

import flexunit.framework.Assert;

/**
 * TBD
 * @author Andras Csizmadia
 */
public class QRDecoderTest {
    [Before]
    public function setUp():void {
        trace("setUp");
    }

    [After]
    public function tearDown():void {
        trace("tearDown");
    }

    [Test]
    public function test_decodeNull():void {
        const decodeResult:String = decodeBitmap(new Bitmap(new BitmapData(320, 240, false, 0x00000000)));
        Assert.assertNull(decodeResult);
    }

    [Test]
    public function test_decodeURL():void {
        const decodeResult:String = decodeBitmap(new TestAssets.URLQR());
        Assert.assertEquals(decodeResult, "http://rubyflow.com");
    }


    [Test]
    public function test_decodeVCard():void {
        const decodeResult:String = decodeBitmap(new TestAssets.VCardQR());
        Assert.assertTrue(decodeResult.indexOf("BEGIN:VCARD") == 0);
    }

    // HELPER

    private function decodeBitmap(image:Bitmap):String {
        const reader:QRImage = new QRImage();
        const decoder:QRDecoder = new QRDecoder();
        const detector:IQRDetector = new QRDetector(image);
        const readerResult:Array = reader.process(detector.detect());
        if (!readerResult)
            return null;
        decoder.setQR(readerResult);
        const decodeResult:String = decoder.startDecode();
        trace(decodeResult);
        return decodeResult;
    }
}
}
