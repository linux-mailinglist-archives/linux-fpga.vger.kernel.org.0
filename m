Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249324B7696
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Feb 2022 21:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbiBOSXY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Feb 2022 13:23:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiBOSXX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 15 Feb 2022 13:23:23 -0500
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342DFC4E29;
        Tue, 15 Feb 2022 10:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:
         references;
        bh=4ea0lgdbQAVCZDxpFFT2YdXX5BI7YGO8Ht6ckrwZhHg=;
        b=X63cxMFShB+1K/6yb0SV1pd0O+vzkwkregB6VG6YR+lXD/XkFpeIT+XRw6VNpW0NVaavwFFWLqXf9
         4Ckk3tfS+E/lKjlHJxHlQX3FDmzShgw1JO1235CeI4VuRSCAS/N5uulpeKSkVnG0JhOOZYRDOBrdQA
         UgznDdK3ctb9FeHys454IZMCJ45LihKAIxIKOe5O7rssq9P1D7H1IDSSzg2RMvr7SUsxvulNnMtVhl
         3SU+CcwHpMLKltJz/scvfYOeHjFaL652mE61UQqAMJhd7e8jTJ6k52a50n8GtJpgW1G+RqmpY3HfW+
         SIJnmW7Q+zyGvMH5iLtbgPDJBvK+Gpw==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.2.1403, Stamp: 3], Multi: [Enabled, t: (0.000009,0.008659)], BW: [Enabled, t: (0.000022,0.000002)], RTDA: [Enabled, t: (0.064652), Hit: No, Details: v2.25.0; Id: 15.52k0kj.1frv9v0as.6jqg; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from x260 ([178.70.66.234])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Tue, 15 Feb 2022 21:22:50 +0300
Date:   Tue, 15 Feb 2022 21:05:02 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Conor Dooley <mail@conchuod.ie>, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, system@metrotek.ru
Subject: Re: [PATCH v2] fpga: microsemi-spi: add Microsemi FPGA manager
Message-ID: <20220215180502.gqcsz7rdxygiva3y@x260>
References: <20220214133835.25097-1-i.bornyakov@metrotek.ru>
 <20220215115853.26491-1-i.bornyakov@metrotek.ru>
 <d0890e09-5d4a-5cce-832d-26e64b74ac54@conchuod.ie>
 <YgvoXgqM65M97qib@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgvoXgqM65M97qib@epycbox.lan>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello Conor, Moritz

On Tue, Feb 15, 2022 at 09:52:30AM -0800, Moritz Fischer wrote:
> Hi Conor, Ivan,
> 
> On Tue, Feb 15, 2022 at 05:37:04PM +0000, Conor Dooley wrote:
> > Hey Ivan,
> > Firstly thanks for the patch(es), stumbled across them today.
> > As you may know Microsemi has been acquired by Microchip, so
> > s/microsemi/microchip/ please. This would make the correct vendor
> > prefix for compatible strings "microchip". While you've said this is
> > for the PolarFire FPGA, there is prescendent for using "mpfs" for the
> > PolarFire SoC FPGA in the kernel - so if you could change the uses of
> > "polarfire" to "mpf" that'd be great.
> 
> I personally don't have a strong opinion on hte microchip vs microsemi
> here. We have precedent with intel/altera.
> 

Me neither, so I'll do what Conor asked.

> > 
> > The current item on my own todo list is the opposite side of this,
> > reprogramming the FPGA via the system controller acting as a SPI
> > master for PolarFire SoC.
> > I will get back to you when I have a better idea of what (if any) code
> > can be made generic between both modes. In the meantime, I will get
> > together a setup to test SPI slave reprogramming of the PolarFire (SoC)
> > 
> > Thanks,
> > Conor <conor.dooley@microchip.com>
> 
> Thanks for chiming in. Always nice to have vendors help out reviewing.
>

Yeah, that's great, thanks in advance Conor.

> > > Add support to the FPGA manager for programming Microsemi Polarfire
> > > FPGAs over slave SPI interface.
> > >
> > > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > > ---
> > > Changelog:
> > >   v1 -> v2: fix printk formating
> > >
> > >  drivers/fpga/Kconfig         |   9 +
> > >  drivers/fpga/Makefile        |   1 +
> > >  drivers/fpga/microsemi-spi.c | 366 +++++++++++++++++++++++++++++++++++
> > >  3 files changed, 376 insertions(+)
> > >  create mode 100644 drivers/fpga/microsemi-spi.c
> > >
> > --<snip>--
> 
> I'll take a closer look once the bot's complaints are addressed.
> 
> Thanks,
> Moritz

Thanks in advance Moritz.

