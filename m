Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F8258D478
	for <lists+linux-fpga@lfdr.de>; Tue,  9 Aug 2022 09:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiHIHU3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 9 Aug 2022 03:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbiHIHUZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 9 Aug 2022 03:20:25 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7833DB493;
        Tue,  9 Aug 2022 00:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=cC9HTDFYURx/NMwEKphEdNhFO++q3yjpjJZDYvPvhWA=;
        b=VuAB7BbI6tYWGusjvoPanRiPvR6nAupNGlzXx5gID3+eObOdgoeX1sR7BRfj824bl1IXdMIdu3Qq5
         uEhtsBUITXW1us+Uu7ZKXpum/OaBRVFcvKCwJhjBcYKEIj++jwMTCNLM67OvIuYTGRYkj5sRuwT+og
         ZYr2Ab7E69xcm0o4hSDWDN8dquT+n6a3Wtfl8ucX9f4ukGvXMSgpG9mduVXKpkwigjFNIGqBKHVWQ9
         R7PVG+HDWNZhZOOviIX20o/4gL/Bp+nuiI0kGDoA+iTL+3KFKoug4ZMaJEh18JrAY20BqSAjCfysO7
         4EmpPhngoGrSTidI0UrRqa4HrCVC1TQ==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000009,0.005356)], BW: [Enabled, t: (0.000013,0.000001)], RTDA: [Enabled, t: (0.074412), Hit: No, Details: v2.41.0; Id: 15.52k0ad.1ga0nisot.3s26; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([92.100.85.134])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Tue, 9 Aug 2022 10:19:52 +0300
Date:   Tue, 9 Aug 2022 09:54:31 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Daniel =?utf-8?B?R2zDtmNrbmVy?= <dg@emlix.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: Re: [PATCH v5 1/2] fpga: ecp5-spi: add Lattice ECP5 FPGA manager
Message-ID: <20220809065431.nbfopsvx6teja37i@x260>
References: <20220719112335.9528-1-i.bornyakov@metrotek.ru>
 <20220719112335.9528-2-i.bornyakov@metrotek.ru>
 <20220801072448.GA11993@homes.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220801072448.GA11993@homes.emlix.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Aug 01, 2022 at 09:24:49AM +0200, Daniel Glöckner wrote:
> Hi,
> 
> On Tue, Jul 19, 2022 at 02:23:34PM +0300, Ivan Bornyakov wrote:
> > +	/* Enter init mode */
> > +	gpiod_set_value(priv->program, 1);
> > +
> > +	ret = ecp5_poll_gpio(priv->init, true);
> > +	if (!ret)
> > +		ret = ecp5_poll_gpio(priv->done, false);
> > +
> > +	if (ret) {
> > +		dev_err(dev, "Failed to go to initialization mode\n");
> > +		return ret;
> > +	}
> 
> To me the documentation looks like the chip will deassert INITN after
> tINITL regardless of the PROGRAMN signal. At 55ns max tINITL is too
> short to reliably sample INITN while it is asserted when we have
> interrupts enabled. Can you confirm that INITN stays asserted as long
> as PROGRAMN is asserted?

I confirm that INITN stays asserted while PROGRAMN is asserted, just
rechecked.

