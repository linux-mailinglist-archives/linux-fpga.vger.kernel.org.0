Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2226B578442
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jul 2022 15:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbiGRNrl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Jul 2022 09:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbiGRNrj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Jul 2022 09:47:39 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD60252B0;
        Mon, 18 Jul 2022 06:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=dJ8IOKPH9fu52HqQKgaZQLS3DUP2fP2ZVIrOaBh8llI=;
        b=axg4fbzrez5wMmI5aCR2r+f7In2qUsBYwrLid9tjcEZ9UR7kIEbweSDKTegBug1Wx2BqN3iErx1ui
         9YqXt8d53RiMrtG/RuUniZt3qrZE0e4q/K+MU6BWKr5rKnENhxxjBnhOSdPNeoM7R3woTFiUM/gkK7
         nirqVPdaFTxgilqGFhQeaLrId2TEQqiL6xgEGIIiYGhzzzNhararPBWtcF25Aa10UqSu2tvxA4mH5V
         Npa+pITBSA+u3Nk9WgtbahJpmKYApcO304HguVJUUhtNtLH8DAv+huoOENXzoBakB5NqimPPLh08P/
         GjS8++TS27uTUeiqEyllpVrLTQqsxvA==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000008,0.013350)], BW: [Enabled, t: (0.000013,0.000001)], RTDA: [Enabled, t: (0.078085), Hit: No, Details: v2.40.0; Id: 15.52k88b.1g88p09so.39q14; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 18 Jul 2022 16:47:15 +0300
Date:   Mon, 18 Jul 2022 16:46:54 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: Re: [PATCH 2/2] dt-bindings: fpga: add binding doc for ecp5-spi fpga
 mgr
Message-ID: <20220718134654.w2b4vmixjijhvqta@h-e2.ddg>
References: <20220714122657.17972-1-i.bornyakov@metrotek.ru>
 <20220714122657.17972-3-i.bornyakov@metrotek.ru>
 <044a9736-a4ec-c250-7755-c80a5bcbe38b@linaro.org>
 <20220715100356.fwjomifweifn6zsr@h-e2.ddg>
 <2a96f734-010d-b42d-8418-715d7c420272@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a96f734-010d-b42d-8418-715d7c420272@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jul 18, 2022 at 03:06:18PM +0200, Krzysztof Kozlowski wrote:
> On 15/07/2022 12:03, Ivan Bornyakov wrote:
> > On Fri, Jul 15, 2022 at 11:33:54AM +0200, Krzysztof Kozlowski wrote:
> >> On 14/07/2022 14:26, Ivan Bornyakov wrote:
> >>> Add Device Tree Binding doc for Lattice ECP5 FPGA manager using slave
> >>> SPI to load .bit formatted uncompressed bitstream image.
> >>>
> >>> Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> >>> ---
> >>>  .../fpga/lattice,ecp5-spi-fpga-mgr.yaml       | 71 +++++++++++++++++++
> >>>  1 file changed, 71 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml
> >>> new file mode 100644
> >>> index 000000000000..79868f9c84e2
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/fpga/lattice,ecp5-spi-fpga-mgr.yaml
> >>> @@ -0,0 +1,71 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/fpga/lattice,ecp5-spi-fpga-mgr.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Lattice ECP5 FPGA manager.
> >>> +
> >>> +maintainers:
> >>> +  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
> >>> +
> >>> +description:
> >>> +  Device Tree Bindings for Lattice ECP5 FPGA Manager using slave SPI to
> >>> +  load the uncompressed bitstream in .bit format.
> >>
> >> s/Device Tree Bindings for//
> >>
> >> Instead describe the hardware you are adding bindings for. What is a
> >> "Manager"? It is so broad and unspecific... It is some dedicated
> >> hardware to communicate with FPGA or you just called this regular FPGA
> >> interface exposed to the CPU/SoC?
> >>
> > 
> > "FPGA Manager" is a kernel subsystem that exports a set of functions for
> > programming an FPGA with a bitstream image.
> > See Documentation/driver-api/fpga/fpga-mgr.rst
> 
> This is what you want to include in the bindings document? How is it
> related to bindings? We do not talk about driver API but we talk about
> hardware. Bindings are for the hardware.
> 

I've send out v3 not too long ago. If you found the wording there not
good enough, could you look through
Documentation/devicetree/bindings/fpga/ and point me to a proper example?

> > 
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - lattice,ecp5-spi-fpga-mgr
> >>
> >> Do not encode interface name in compatible so no "spi".
> >>
> > 
> > Recently when I submitted FPGA manager for Microchip PolarFire, I was
> > asked the opposite, to add "spi" in compatible. The reason was that FPGA
> > can be programmed through other interfaces as well.
> 
> I don't see such comment from Rob (DT maintainer):
> https://lore.kernel.org/all/?q=%22dt-bindings%3A+fpga%3A+add+binding+doc+for+microchip-spi+fpga+mgr%22
> 
> Can you point me to it?
> 

Yeah, it was not Rob but other developer:
https://lore.kernel.org/all/79328410-e56f-7c8a-9d17-de9bfdb98f51@microchip.com/

And at that point I had not even written the bindings doc, so neither
you nor Rob weren't in the Cc.

But eventually Rob reviewed DT bindings doc for PolarFire with
compatible string to be "microchip,mpf-spi-fpga-mgr"
https://lore.kernel.org/all/YkORrgC1FdzaKCMW@robh.at.kernel.org/

So I thought it was OK.

