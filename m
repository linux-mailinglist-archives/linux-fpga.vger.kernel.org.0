Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F95642C4F
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Dec 2022 16:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiLEPvo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Dec 2022 10:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiLEPvn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Dec 2022 10:51:43 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DF811459;
        Mon,  5 Dec 2022 07:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670255502; x=1701791502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/MxMSWAumjaR4B7gfinrrCVoXvPVOfwPZVTJARGywLQ=;
  b=L2Y66EBupbfRCXOakG+muXOQ00AgPCE4z8QZKZQ+JGst29LiINb9R0Dm
   eKzby+mMkAY1CbbH13mjyMSXHHVsAe85Z1uaYcCkQ1BWXDfDEJAkIfyhQ
   qWpcqDraKhG1mMMh0OEQ2ZcDDhmZyi0lkrpr2gQmJYW3VwRk7k0LKN0Ge
   dTadDlRbTo0fNFfaBxp6j3iudYePkyoVlIgbJn17TMiKS15G4WZtNorbP
   0wnR8J9aOFqtV7rSVtQg2G1yHuJqjjXPsq4YklY2c9az4yt1Q6j2x3HV2
   XtKtMUg505ulv00R/UnXq4mdPV3NXJBj8aMOecwYpQ90iTd9fAfLtFRBw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="343376043"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="343376043"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 07:51:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="752237461"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="752237461"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 05 Dec 2022 07:51:39 -0800
Date:   Mon, 5 Dec 2022 23:41:55 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/9] mfd: intel-m10-bmc: Downscope SPI defines &
 prefix with M10BMC_SPI
Message-ID: <Y44RQ4Wutr/I1xsp@yilunxu-OptiPlex-7050>
References: <20221202100841.4741-1-ilpo.jarvinen@linux.intel.com>
 <20221202100841.4741-7-ilpo.jarvinen@linux.intel.com>
 <Y4onmwWT8duVV0Sv@yilunxu-OptiPlex-7050>
 <2b253321-72ff-f15a-8879-aa41dce48055@intel.com>
 <b09aabe4-3f82-70f0-aca2-f1cdf7d6a26@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b09aabe4-3f82-70f0-aca2-f1cdf7d6a26@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-05 at 11:31:06 +0200, Ilpo Järvinen wrote:
> On Fri, 2 Dec 2022, Russ Weight wrote:
> > On 12/2/22 08:28, Xu Yilun wrote:
> > > On 2022-12-02 at 12:08:38 +0200, Ilpo Järvinen wrote:
> > >> Move SPI based board definitions to per interface file from the global
> > >> header. This makes it harder to use them accidently in the
> > >> generic/interface agnostic code. Prefix the defines with M10BMC_SPI
> > > I'm not sure if the register layout is actually bound to the bus
> > > interface. My experience is the register layout is always decided by
> > > board type. Is it possible there will be a new SPI based board but
> > > has different register layout in future?
> > >
> > > So is M10BMC_SPI_XXX a good nam
> > 
> > There could be future devices, spi or pmci based, that require different
> > addresses for some of these values, and at that time we would need to
> > additional versions of some of these macros using different names.
> > Right now, spi and pmci are the primary differentiating factors. I'm not
> > sure how to improve on the naming. Do you have any suggestions?
> 
> It's per board type yes, but there's a strong clustering currently on 
> spi/pmci differentiation. That implies a one define applies to multiple 
> board types so naming it, e.g., after a single board type seems not much 
> better than the current approach.

I think it is better to name after one of the board type among all its
supported types. At least it clearly indicates they are related to board
type.

Actually it is normal for many driver modules. A driver was initially
implemented for one board type, and was named by the initial board.
But later you have more board types compatible to the driver, you don't
change the driver name, just use it.

Thanks,
Yilun

> 
> I've even thought myself of removing those defines as they seem one-time 
> use ones after introducing the csr_map. Defining the csr_map using members
> kinda documents what a literal is about if I'd put just a number there.
> The added benefit a few capital letters in a define provides is IMHO very
> questionable.
> 
> Also m10bmc_spi_csr_map name suffers from the same problem, BTW.
> 
> I could, of course now that they're downscoped, drop _SPI_ or _PMCI_ from 
> their names if that's ok for you? ...But that wouldn't address the next 
> version naming problem at all. But I don't anyway know, without a crystal 
> ball, know how to address the future naming needs.
> 
> -- 
>  i.

