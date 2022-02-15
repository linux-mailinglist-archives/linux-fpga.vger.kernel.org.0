Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94F94B7565
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Feb 2022 21:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240783AbiBORwo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Feb 2022 12:52:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiBORwn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 15 Feb 2022 12:52:43 -0500
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1B5F11B7;
        Tue, 15 Feb 2022 09:52:33 -0800 (PST)
Received: by mail-pj1-f54.google.com with SMTP id y9so18020627pjf.1;
        Tue, 15 Feb 2022 09:52:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EeWKQ0eSOfEOUNiOqe9rH7RJP4VfPyvNvd5R+f4N9f8=;
        b=e/ZbU2zZBhhGYHW0wZt85Yw+ULHXEZCFDH6KF6ANlXiBMf7iXWK7Y/zfyl7+mx80Ii
         i6n1IEwYkfY2JH41bBLkpU5HPHahFPSw9Hf5GXB007lMs+SfzI/QDvUrUvxgC31T14GL
         32Gj6BYEU5Yau3HVHRXlTpCcCCMfTMSOIvIbMYG+XE/5M816GI/+yRLp3LuQkmnFbWFq
         ySoEV/oQuJTN7QkXpNz8p7tUkeyDTKR19NZ8l6xnnbzDRaKo7V1w8SMh+sGZvGrnrukf
         fbxfjzrIy77brOss/zrkJNkgMZdznf/TV7nHoxmmrUuwFJGiRGYhcb7Fn1qN/2W9oqNd
         Kerw==
X-Gm-Message-State: AOAM5337fCMWsNwx6XIOnZv/0k0R5RMBIieFZUDv7eZNNfVZxKImuvgS
        Q5AV3S6ozZrGDAPT2e9gCtI=
X-Google-Smtp-Source: ABdhPJxRHFGeXLqJk+vJ8VLtcFX9UvbUWSISEVKyixBZptY7v28xUppe6W7BEQeWSBccgHXJgDU07w==
X-Received: by 2002:a17:903:228c:: with SMTP id b12mr162376plh.36.1644947552447;
        Tue, 15 Feb 2022 09:52:32 -0800 (PST)
Received: from localhost ([2601:647:5b00:ece0:aab:34ff:52ca:a7a5])
        by smtp.gmail.com with ESMTPSA id kb12sm6870914pjb.20.2022.02.15.09.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 09:52:31 -0800 (PST)
Date:   Tue, 15 Feb 2022 09:52:30 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        system@metrotek.ru
Subject: Re: [PATCH v2] fpga: microsemi-spi: add Microsemi FPGA manager
Message-ID: <YgvoXgqM65M97qib@epycbox.lan>
References: <20220214133835.25097-1-i.bornyakov@metrotek.ru>
 <20220215115853.26491-1-i.bornyakov@metrotek.ru>
 <d0890e09-5d4a-5cce-832d-26e64b74ac54@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0890e09-5d4a-5cce-832d-26e64b74ac54@conchuod.ie>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Conor, Ivan,

On Tue, Feb 15, 2022 at 05:37:04PM +0000, Conor Dooley wrote:
> Hey Ivan,
> Firstly thanks for the patch(es), stumbled across them today.
> As you may know Microsemi has been acquired by Microchip, so
> s/microsemi/microchip/ please. This would make the correct vendor
> prefix for compatible strings "microchip". While you've said this is
> for the PolarFire FPGA, there is prescendent for using "mpfs" for the
> PolarFire SoC FPGA in the kernel - so if you could change the uses of
> "polarfire" to "mpf" that'd be great.

I personally don't have a strong opinion on hte microchip vs microsemi
here. We have precedent with intel/altera.

> 
> The current item on my own todo list is the opposite side of this,
> reprogramming the FPGA via the system controller acting as a SPI
> master for PolarFire SoC.
> I will get back to you when I have a better idea of what (if any) code
> can be made generic between both modes. In the meantime, I will get
> together a setup to test SPI slave reprogramming of the PolarFire (SoC)
> 
> Thanks,
> Conor <conor.dooley@microchip.com>

Thanks for chiming in. Always nice to have vendors help out reviewing.
> 
> > Add support to the FPGA manager for programming Microsemi Polarfire
> > FPGAs over slave SPI interface.
> >
> > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > ---
> > Changelog:
> >   v1 -> v2: fix printk formating
> >
> >  drivers/fpga/Kconfig         |   9 +
> >  drivers/fpga/Makefile        |   1 +
> >  drivers/fpga/microsemi-spi.c | 366 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 376 insertions(+)
> >  create mode 100644 drivers/fpga/microsemi-spi.c
> >
> --<snip>--

I'll take a closer look once the bot's complaints are addressed.

Thanks,
Moritz
