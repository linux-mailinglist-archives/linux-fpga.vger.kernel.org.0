Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33D5585411
	for <lists+linux-fpga@lfdr.de>; Fri, 29 Jul 2022 19:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbiG2Q66 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 29 Jul 2022 12:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiG2Q65 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 29 Jul 2022 12:58:57 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C881E89A63;
        Fri, 29 Jul 2022 09:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=HcyS1kHLPZESdGp9R+oyPMtufBfDWfydet05Vxb7ves=;
        b=cjwCDrbFQMPGAFMf7CwS3hbVeF0L1QgdRtCzntfr6jV/Nde1TBFZlb+iQ1Go80mbJBsNC5wxGBzNg
         Po6YVgkyCIjsNH9NMTnXj7MZud6wK91Aw3GrM7jtIo+r5ke1lLEqvtbUUbXhgwnaEFg30SoykgSNDu
         GXLKyQ0jQZNOhYXQsLAWnh1TOqCR1zHgB+bJAZCn5nuNGzQoTHDdlJVqAK4IMX/DyblhVE5dZbjdci
         VzlNoUGHc3AqGEY7BF0dI3umPdyQoKAxQzxup33pYjF3hASj0BNeImHt1LLyv89CrpDZsOEnam9dpa
         K0zDQ35r5/9PLn19/BebA1KzYIPKKxA==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000012,0.006052)], BW: [Enabled, t: (0.000035,0.000001)], RTDA: [Enabled, t: (0.081346), Hit: No, Details: v2.41.0; Id: 15.52k00k.1g95ealga.9p5; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([85.93.58.13])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Fri, 29 Jul 2022 19:58:36 +0300
Date:   Fri, 29 Jul 2022 19:33:47 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Daniel =?utf-8?B?R2zDtmNrbmVy?= <dg@emlix.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 2/2] dt-bindings: fpga: add binding doc for ecp5-spi
 fpga mgr
Message-ID: <20220729163347.irqqqcvh2biliqg2@x260>
References: <20220719112335.9528-1-i.bornyakov@metrotek.ru>
 <20220719112335.9528-3-i.bornyakov@metrotek.ru>
 <20220729090123.GA28299@homes.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220729090123.GA28299@homes.emlix.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jul 29, 2022 at 11:01:24AM +0200, Daniel Glöckner wrote:
> Hi,
> 
> On Tue, Jul 19, 2022 at 02:23:35PM +0300, Ivan Bornyakov wrote:
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - lattice,ecp5-fpga-mgr
> 
> Since this driver uses the same interface as the existing
> drivers/fpga/machxo2-spi.c driver, wouldn't it be advisable to use a
> similar compatible id, i.e. lattice,ecp5-slave-spi?
> 

To quote Krzysztof Kozlowski from v1 review:
 > Do not encode interface name in compatible so no "spi"

See https://lore.kernel.org/linux-fpga/044a9736-a4ec-c250-7755-c80a5bcbe38b@linaro.org/

> > +required:
> > +  - compatible
> > +  - reg
> > +  - program-gpios
> > +  - init-gpios
> > +  - done-gpios
> 
> I think some of the GPIOs can be made optional by reading the status
> register or using the refresh command, assuming the slave spi interface
> stayed enabled after previous programming and we are not dealing with
> several chained FPGAs. But that can of course be left as an exercise for
> other developers.

I would prefer the latter.

