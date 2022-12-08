Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B04646F30
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Dec 2022 12:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiLHL6D (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Dec 2022 06:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLHL6C (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 8 Dec 2022 06:58:02 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F4D3E085;
        Thu,  8 Dec 2022 03:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670500682; x=1702036682;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RhThfi2MnPhsR7HzMO5D1K17BZtYy9Njo3aLlEab60U=;
  b=HQeE3f0R1q1crURFAI17OEbvvpf/FQfgffHoEXanj7kmO5LaTu/L2RqJ
   mdYrt5sFO+wjb839MOiss3yD0EH0WPfOvo0qe0I7AAXthuFVbJlBkQSLK
   rbPoBbrNtY9hIce6izWPBxaOpNtQynZJG0WzwcCIDQQKBgr3M7x/ZLt9m
   5AuNG8B8wW7hAYpL1wbo/ivMsW0xF/VUgpgiSj7RAhDn6YA0q4veAl4TX
   6bedKPbMvLkS2jZ/t5iqdIV4W0gY+ApKSOKjj+kWl4oUBsfT2Lk1Fm3eG
   SzPO99LiPkr/14KY8k1/a2S+XvZ11XPWX5l8+WmxOTTuSODfz8OqTTM6i
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="381444666"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="381444666"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 03:58:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="715573021"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="715573021"
Received: from pors-mobl3.ger.corp.intel.com ([10.252.39.224])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 03:57:57 -0800
Date:   Thu, 8 Dec 2022 13:57:56 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Xu Yilun <yilun.xu@intel.com>
cc:     Russ Weight <russell.h.weight@intel.com>,
        linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/9] mfd: intel-m10-bmc: Downscope SPI defines & prefix
 with M10BMC_SPI
In-Reply-To: <Y44RQ4Wutr/I1xsp@yilunxu-OptiPlex-7050>
Message-ID: <9579a09f-a5a7-adb4-e34b-2416ae9b3ef@linux.intel.com>
References: <20221202100841.4741-1-ilpo.jarvinen@linux.intel.com> <20221202100841.4741-7-ilpo.jarvinen@linux.intel.com> <Y4onmwWT8duVV0Sv@yilunxu-OptiPlex-7050> <2b253321-72ff-f15a-8879-aa41dce48055@intel.com> <b09aabe4-3f82-70f0-aca2-f1cdf7d6a26@linux.intel.com>
 <Y44RQ4Wutr/I1xsp@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-273247173-1670500681=:1682"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-273247173-1670500681=:1682
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 5 Dec 2022, Xu Yilun wrote:

> On 2022-12-05 at 11:31:06 +0200, Ilpo Järvinen wrote:
> > On Fri, 2 Dec 2022, Russ Weight wrote:
> > > On 12/2/22 08:28, Xu Yilun wrote:
> > > > On 2022-12-02 at 12:08:38 +0200, Ilpo Järvinen wrote:
> > > >> Move SPI based board definitions to per interface file from the global
> > > >> header. This makes it harder to use them accidently in the
> > > >> generic/interface agnostic code. Prefix the defines with M10BMC_SPI
> > > > I'm not sure if the register layout is actually bound to the bus
> > > > interface. My experience is the register layout is always decided by
> > > > board type. Is it possible there will be a new SPI based board but
> > > > has different register layout in future?
> > > >
> > > > So is M10BMC_SPI_XXX a good nam
> > > 
> > > There could be future devices, spi or pmci based, that require different
> > > addresses for some of these values, and at that time we would need to
> > > additional versions of some of these macros using different names.
> > > Right now, spi and pmci are the primary differentiating factors. I'm not
> > > sure how to improve on the naming. Do you have any suggestions?
> > 
> > It's per board type yes, but there's a strong clustering currently on 
> > spi/pmci differentiation. That implies a one define applies to multiple 
> > board types so naming it, e.g., after a single board type seems not much 
> > better than the current approach.
> 
> I think it is better to name after one of the board type among all its
> supported types. At least it clearly indicates they are related to board
> type.
> 
> Actually it is normal for many driver modules. A driver was initially
> implemented for one board type, and was named by the initial board.
> But later you have more board types compatible to the driver, you don't
> change the driver name, just use it.

Ok, I'll do it that way then.

-- 
 i.

--8323329-273247173-1670500681=:1682--
